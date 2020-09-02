import Foundation
import Model
import Infra

public class PokemonDetailViewModel {
    
    public var pokemonDetail: PokemonDetail?
    let service = HttpService()
    
    public init() {}
        
    public func getPokemon(url: URL, completion: @escaping (Result<PokemonDetail?, HttpError>) -> Void) {        
        service.get(url: url) { result in
            switch result {
            case .success(let data):
                if data != nil {
                    if let detail: PokemonDetail = data?.toModel() {
                        self.pokemonDetail = detail
                        completion(.success(self.pokemonDetail))
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

