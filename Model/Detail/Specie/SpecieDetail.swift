import Foundation

public struct SpecieDetail : Model {
    public let color : Color?
    public let evolution_chain : Evolution_chain?
    public let varieties : [Varieties]?
    public let base_happiness : Int?
    public let capture_rate : Int?
    public let flavor_text_entries : [Flavor_text_entries]?
    
        
    public init(color : Color?, evolution_chain : Evolution_chain?, varieties : [Varieties]?, base_happiness : Int?, capture_rate : Int?, flavor_text_entries : [Flavor_text_entries]?) {
        self.color = color
        self.evolution_chain = evolution_chain
        self.varieties = varieties
        self.base_happiness = base_happiness
        self.capture_rate = capture_rate
        self.flavor_text_entries = flavor_text_entries
    }
}
