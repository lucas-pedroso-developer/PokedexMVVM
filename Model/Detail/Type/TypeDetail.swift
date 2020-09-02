import Foundation

public struct TypeDetail : Model {
    public let pokemon : [TypePokemon]?
        
    public init(pokemon: [TypePokemon]?) throws {
        self.pokemon = pokemon
    }

}
