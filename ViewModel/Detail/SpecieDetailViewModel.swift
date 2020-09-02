import Foundation
import Model
import Infra

public class SpecieDetailViewModel {
    
    let service = HttpService()
    public var specieDetail: SpecieDetail?
        
    public init() {}
    
    public func getDataDescription() -> String {
        var result: String = ""
        if let flavor_text_entries = self.specieDetail?.flavor_text_entries {
           for flavor in flavor_text_entries {
               if (flavor.language?.name?.elementsEqual("en"))! && ((flavor.language?.name?.elementsEqual("alpha-sapphire")) != nil) {
                   if let text = flavor.flavor_text {
                       result = text.replacingOccurrences(of: "\n", with: " ")
                   }
               }
           }
           return result
        }
        return ""
    }
    
    public func getSpecie(url: URL, completion: @escaping (Result<SpecieDetail?, HttpError>) -> Void) {
        service.get(url: url) { result in
            switch result {
            case .success(let data):
                if data != nil {
                    if let specie: SpecieDetail = data?.toModel() {
                        self.specieDetail = specie
                        completion(.success(self.specieDetail))
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
