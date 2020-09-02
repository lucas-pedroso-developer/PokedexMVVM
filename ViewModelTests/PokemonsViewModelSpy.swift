import Foundation
import Model
import Infra


public class PokemonsViewModelSpy {
    public var pokemons: Pokemons?
    public var resultsArray: [Results]?
    
    public var urls = [URL]()
    var data: Data?
    var completion: ((Result<Pokemons?, HttpError>) -> Void)?
        
    public func appendPokemon(name: String, url: String) {
        self.resultsArray?.append(Results(name: name, url: url))
    }
    
    public func getPokemons(url: URL, completion: @escaping (Result<Pokemons?, HttpError>) -> Void) {
        self.urls.append(url)
        self.completion = completion
    }
        
    func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
    }
    
    func completeWithData(_ pokemons: Pokemons) {
        completion?(.success(pokemons))
    }
    
}
