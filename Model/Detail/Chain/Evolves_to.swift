import Foundation

public struct Evolves_to : Model {
    public var evolves_to : [Evolves_to]?
    public var species : Species?

    public init(evolves_to : [Evolves_to]?, species : Species?) {
        self.evolves_to = evolves_to
        self.species = species
    }

}
