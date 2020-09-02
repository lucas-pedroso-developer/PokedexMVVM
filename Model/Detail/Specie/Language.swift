import Foundation

public struct Language : Model {
    public let name : String?
    public let url : String?

    public init(name: String, url: String) throws {
        self.name = name
        self.url = url
    }

}
