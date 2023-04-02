import Foundation
import Combine
import SwiftUI

typealias MyAppStore = Store<AppState, AppAction>

public typealias Reducer<State, Action> = (State, Action) -> State
public typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>

public final class Store<State, Action>: ObservableObject {

    @Published private(set) var state: State
    var isEnabled = true

    private let queue = DispatchQueue(label: "store", qos: .userInitiated)
    private let reducer: Reducer<State, Action>
    private let middlewares: [Middleware<State, Action>]
    private var subscriptions = Set<AnyCancellable>()

    public init(
        initial state: State,
        reducer: @escaping Reducer<State, Action>,
        middlewares: [Middleware<State, Action>]
    ) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
    }

    public func restoreState(_ state: State) {
        self.state = state
    }

    public func dispatch(_ action: Action) {
        guard isEnabled else { return }

        queue.sync {
            self.dispatch(self.state, action)
        }
    }

    private func dispatch(_ currentState: State, _ action: Action) {
        let newState = reducer(currentState, action)

        middlewares.forEach { middleware in
            middleware(newState, action)
                .receive(on: RunLoop.main)
                .sink(receiveValue: dispatch)
                .store(in: &subscriptions)
        }

        state = newState
    }
}
