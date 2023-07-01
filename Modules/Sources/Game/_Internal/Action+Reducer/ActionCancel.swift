//
//  ActionCancel.swift
//  
//
//  Created by Hugues Stephano TELOLAHY on 22/06/2023.
//

struct ActionCancel: GameReducerProtocol {
    let arg: CancelArg

    func reduce(state: GameState) throws -> GameState {
        var state = state

        switch arg {
        case .next:
            state.queue.remove(at: 0)

        case .startTurn:
            guard let index = state.queue.firstIndex(where: { $0.isStartTurnEffect() }) else {
                return state
            }
            state.queue.remove(at: index)
        }

        return state
    }
}

private extension GameAction {
    func isStartTurnEffect() -> Bool {
        guard case let .resolve(_, ctx) = self,
              ctx.get(.card) == .drawOnSetTurn else {
            return false
        }

        return true
    }
}
