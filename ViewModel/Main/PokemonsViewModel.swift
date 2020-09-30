import Foundation
import Model
import Infra
import UIKit
import RxSwift

public class PokemonsViewModel {
        
    public var pokemons: Pokemons?
    public var resultsArray: [Results]?
    public var pokemonNameToSearch: String = ""
    
    let service = HttpService()
    
    public init() {}
    
    public func numberOfRows(searchIsActive: Bool) -> Int {
        if searchIsActive {
            var pokemonsFiltered = self.pokemons?.results!.filter {
                ($0.name?.contains(self.pokemonNameToSearch))!
            }
                                                
            if let filtered = pokemonsFiltered {
                self.resultsArray = filtered
                return filtered.count
            }
        } else {
            if let array = pokemons?.results {
                return array.count
            }
        }
        return 0
    }
    
    public func cellSize(collectionView: UICollectionView) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
    }
    
    public func appendPokemon(name: String, url: String) {
        self.resultsArray?.append(Results(name: name, url: url))
    }
            
    public func get(url: URL) -> Observable<(Result<Pokemons?, HttpError>)> {
        return Observable.create { observer in
            self.service.get(url: url) { result in
                switch result {
                case .success(let data):
                    if data != nil {
                        do {
                            let results = try JSONDecoder().decode(Pokemons.self, from: data!)                            
                            if self.pokemons == nil {
                                self.pokemons = results
                                observer.onNext(.success(self.pokemons))
                            } else {
                                self.pokemons?.next = results.next
                                self.pokemons?.results?.append(contentsOf: results.results!)
                                observer.onNext(.success(self.pokemons))
                            }
                        } catch(let error) {
                            observer.onNext(.failure(.noConnectivity))
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

