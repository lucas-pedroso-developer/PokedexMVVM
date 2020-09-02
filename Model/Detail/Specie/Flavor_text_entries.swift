import Foundation

public struct Flavor_text_entries : Model {
    public let flavor_text : String?
    public let language : Language?
    public let version : Version?

    public init(flavor_text : String?, language : Language?, version : Version?)  {
        self.flavor_text = flavor_text
        self.language = language
        self.version = version
    }

}
