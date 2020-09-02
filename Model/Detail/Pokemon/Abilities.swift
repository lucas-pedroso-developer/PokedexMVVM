import Foundation

public struct Abilities : Model {
    public let ability : Ability?
    public let is_hidden : Bool?
    public let slot : Int?
    
    public init(ability : Ability?, is_hidden : Bool?, slot : Int?) {
        self.ability = ability
        self.is_hidden = is_hidden
        self.slot = slot
    }

}
