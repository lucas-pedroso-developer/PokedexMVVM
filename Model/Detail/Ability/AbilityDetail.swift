import Foundation

public struct AbilitiesDetail : Model {
    public let flavor_text_entries : [Ability_Flavor_text_Entries]?
    
    public init(flavor_text_entries : [Ability_Flavor_text_Entries]?) {
        self.flavor_text_entries = flavor_text_entries
    }

}
