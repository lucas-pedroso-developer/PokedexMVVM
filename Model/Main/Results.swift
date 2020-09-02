import Foundation

public struct Results : Model {
    public let name : String?
    public let url : String?
       
    public init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }        
}
