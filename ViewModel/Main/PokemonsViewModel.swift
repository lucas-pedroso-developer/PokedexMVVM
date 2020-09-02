import Foundation
import Model
import Infra

public class PokemonsViewModel {
    
    public var pokemons: Pokemons?
    public var resultsArray: [Results]? 
    let service = HttpService()
    
    public init() {}
    
    public func appendPokemon(name: String, url: String) {        
        self.resultsArray?.append(Results(name: name, url: url))
    }
    
    public func getPokemons(url: URL, completion: @escaping (Result<Pokemons?, HttpError>) -> Void) {
        service.get(url: url) { result in
            switch result {
            case .success(let data):
                if data != nil {
                    do {
                        let results = try JSONDecoder().decode(Pokemons.self, from: data!)
                        if self.pokemons == nil {
                            self.pokemons = results                            
                            completion(.success(self.pokemons))
                        } else {
                            self.pokemons?.next = results.next                            
                            self.pokemons?.results?.append(contentsOf: results.results!)
                            completion(.success(self.pokemons))
                        }
                        
                    } catch(let error) {
                        completion(.failure(.noConnectivity))
                    }
                    
                } else {
                    completion(.failure(.noConnectivity))
                }
            case .failure(let error):
                completion(.failure(.noConnectivity))
            }
        }
    }
}

