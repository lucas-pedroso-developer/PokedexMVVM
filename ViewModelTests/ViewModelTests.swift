import XCTest
import Foundation
import Model
import Infra
@testable import ViewModel

class ViewModelTests: XCTestCase {

    func test_append_results_array(){
        let sut = makeSut()
        sut.appendPokemon(name: "pikachu", url: "www.pikachu.com")
        XCTAssert(sut.resultsArray?.count == 1)
    }
       
    func test_get_should_call_viewModel_with_correct_url() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon")!
        let sut = makeSut()
        sut.getPokemons(url: url) { _ in }
        XCTAssertEqual(sut.urls, [url])
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_error() {
        let sut = makeSut()
        expect(sut, completeWith: .failure(.noConnectivity), when: {
            sut.completeWithError(.noConnectivity)
        })
    }
            
    func makePoke() -> Pokemons {
        return Pokemons(count: 0, next: "", previous: "", results: [])
    }
        
    func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
       return HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
    
    func test_add_should_complete_with_account_if_client_completes_with_valid_data() {
        let sut = makeSut()
        expect(sut, completeWith: .success(makePoke()) , when: {
            sut.completeWithData(makePoke())
        })
    }
}

extension ViewModelTests {
    func makeSut() -> PokemonsViewModelSpy {
        let sut = PokemonsViewModelSpy()
        sut.resultsArray = []
        return sut
    }
            
    func makeURL() -> URL {
        return URL(string: "https://pokeapi.co/api/v2/pokemon")!
    }
    
    func expect(_ sut: PokemonsViewModelSpy, completeWith expectedResult: Result<Pokemons, HttpError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        
        sut.getPokemons(url: makeURL()) { receivedResult in
            switch (expectedResult, receivedResult) {
                case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
                case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount)
                default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead")
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
