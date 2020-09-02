import Foundation

public struct Stats : Model {
    public let base_stat : Int?
    public let effort : Int?
    public let stat : Stat?

    public init(base_stat : Int?, effort : Int?, stat : Stat?) {
        self.base_stat = base_stat
        self.effort = effort
        self.stat = stat
    }
}
