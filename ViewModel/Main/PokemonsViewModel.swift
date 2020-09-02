import Foundation
import Model
import Infra
import UIKit

public class PokemonsViewModel {
    
    public var pokemons: Pokemons?
    public var resultsArray: [Results]? 
    let service = HttpService()
    
    public init() {}
    
    /*if searchActive {
        cell.label.text = self.pokemonsViewModel.resultsArray?[indexPath.item].name!
        let url = self.pokemonsViewModel.resultsArray?[indexPath.item].url
        let id = String(format: "%03d", Int(url!.split(separator: "/").last!)!)
        var imageUrl = URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(id).png")!
        cell.imageView.kf.setImage(with: imageUrl)
    } else {
        if let name = self.pokemonsViewModel.pokemons?.results?[indexPath.item].name {
            cell.label.text = name
        }
        if let url = self.pokemonsViewModel.pokemons?.results?[indexPath.item].url {
            let id = String(format: "%03d", Int(url.split(separator: "/").last!)!)
            var imageUrl = URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(id).png")!
            cell.imageView.kf.setImage(with: imageUrl)
        }
    }*/
    
    public func numberOfRows(searchIsActive: Bool) -> Int {
        if searchIsActive {
            if let array = resultsArray {
                return array.count
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

