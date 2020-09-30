import Foundation
import Alamofire
import RxSwift
import RxCocoa

public class HttpService {
    
    private let session : Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func get(url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        session.request(url, method: .get, encoding: JSONEncoding.default).responseData { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else { return
                completion(.failure(.noConnectivity)) }
            switch dataResponse.result {
                case .failure: completion(.failure(.noConnectivity))
                case .success(let data):
                    switch statusCode {
                    case 204:
                        completion(.success(nil))
                    case 200...299:
                        completion(.success(data))
                    case 401:
                        completion(.failure(.unauthorized))
                    case 403:
                        completion(.failure(.forbidden))
                    case 400...499:
                        completion(.failure(.badRequest))
                    case 500...599:
                        completion(.failure(.serverError))
                    default:
                        completion(.failure(.noConnectivity))
                    }
            }
        }
    }
    
    
    
    
    /*private func populateNews() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
       URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] result in
                print(result)
                if let result = result {
                    self?.articleListVM = ArticleListViewModel(articleList: result)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                } else {
                    print("erro")
                }
            })
    }*/
}


