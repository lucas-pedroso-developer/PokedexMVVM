import Foundation

public struct Pokemons : Model {
    public var count : Int?
    public var next : String?
    public var previous : String?
    public var results : [Results]?

    public init(count: Int?, next: String, previous: String, results: [Results]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}
