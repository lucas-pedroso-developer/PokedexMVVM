import Foundation
import Model
import Infra
import RxSwift

public class PokemonDetailViewModel {
    
    public var pokemonDetail: PokemonDetail?
    let service = HttpService()
    
    public init() {}
      
    public func getPokemon(url: URL) -> Observable<(Result<PokemonDetail?, HttpError>)> {
        return Observable.create { observer in
            self.service.get(url: url) { result in
                switch result {
                case .success(let data):
                    if data != nil {
                        if let detail: PokemonDetail = data?.toModel() {
                            self.pokemonDetail = detail
                            observer.onNext(.success(self.pokemonDetail))
                        }
                    } else {
                        observer.onNext(.failure(.noConnectivity))
                    }
                case .failure(let error):
                    observer.onNext(.failure(.noConnectivity))
                }
            }
            return Disposables.create()
        }
    }
    
    
    
    
}

