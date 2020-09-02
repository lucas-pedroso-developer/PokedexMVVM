import Foundation
import Model
import Infra

public class EvolutionChainDetailViewModel {
    
    public var evolutionChainDetail: EvolutionChainDetail?
    public var speciesArray: [Species]?
    let service = HttpService()
        
    public init() {}
    
    func getEvolutionArray() -> [Species] {
        var array: [Species] = []
        
        if let evolves = self.evolutionChainDetail?.chain?.evolves_to {
            array.append((self.evolutionChainDetail?.chain?.species)!)
            var evolvesToData = evolves
            var hasEvolution = true
                          
            while hasEvolution {
                if evolvesToData.isEmpty {
                    hasEvolution = false
                    break
                }
                if evolvesToData.count == 1 {
                    array.append((evolvesToData[0].species)!)
                    evolvesToData = evolvesToData[0].evolves_to!
                } else {
                    for pokemon in evolvesToData {
                        array.append(pokemon.species!)
                    }
                    evolvesToData = evolvesToData[0].evolves_to!
                }
            }
        }
        print(array)
        return array
    }
    
    public func getPokemonEvolution(url: URL, completion: @escaping (Result<EvolutionChainDetail?, HttpError>) -> Void) {
        service.get(url: url) { result in
            switch result {
            case .success(let data):
                if data != nil {
                    if let evolution: EvolutionChainDetail = data?.toModel() {
                        self.evolutionChainDetail = evolution
                        self.speciesArray = self.getEvolutionArray()
                        completion(.success(self.evolutionChainDetail))
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
