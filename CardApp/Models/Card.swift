import Foundation

/// Cards that are used in a game.
/// Cards can have a cost, can have multiple properties, define additional rules,
/// have actions that can be played and have side effects that happen when they are being played.
struct Card: Codable, Equatable {
    
    /// Unique identifier
    var id: String = ""
    
    /// Name
    var name: String = ""
}
