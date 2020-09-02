import Foundation

public struct EvolutionChainDetail : Model {
    public var baby_trigger_item : String?
    public var chain : Chain?
    public var id : Int?

    public init(baby_trigger_item : String?, chain : Chain?, id : Int?) {
        self.baby_trigger_item = baby_trigger_item
        self.chain = chain
        self.id = id
    }
    
}
