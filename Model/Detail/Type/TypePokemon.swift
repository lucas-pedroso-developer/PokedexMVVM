import Foundation

public struct TypePokemon : Model {
    public let pokemon : Pokemon?
    
    public init(pokemon : Pokemon?) {
        self.pokemon = pokemon
    }

}
