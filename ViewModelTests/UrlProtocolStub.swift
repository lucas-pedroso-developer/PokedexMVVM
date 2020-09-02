import Foundation
import Model

class UrlProtocolStub: URLProtocol {
    
    static var emit: ((URLRequest) -> Void)?    
    static var pokemons: Pokemons?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func observeRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    static func simulate(pokemons: Pokemons?, response: HTTPURLResponse?, error: Error?) {
        UrlProtocolStub.pokemons = pokemons
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }
        
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override open func startLoading() {
        UrlProtocolStub.emit?(request)
        if let response = UrlProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = UrlProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override open func stopLoading() {
        
    }
}
