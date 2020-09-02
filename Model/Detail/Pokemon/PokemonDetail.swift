import Foundation

public struct PokemonDetail : Model {
    public let id : Int?
    public let name : String?
    public let height : Int?
    public let weight : Int?
    public let stats : [Stats]?
    public let abilities : [Abilities]?
    public let types : [Types]?
    public let species : Species?
    public let sprites : Sprites?
        
    public init(id : Int?, name : String?, height : Int?, weight : Int?, stats : [Stats]?, abilities : [Abilities]?,
              types : [Types]?, species : Species?, sprites : Sprites?) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.stats = stats
        self.abilities = abilities
        self.types = types
        self.species = species
        self.sprites = sprites
                
    }
}
