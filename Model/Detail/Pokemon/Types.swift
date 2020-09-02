import Foundation

public struct Types : Model {
    public let slot : Int?
    public let type : Type?

    public init(slot : Int?, type : Type?) {
        self.slot = slot
        self.type = type
    }

}
