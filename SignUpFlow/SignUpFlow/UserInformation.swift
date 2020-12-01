import Foundation

class UserInformation {
    var id: String?
    var password: String?
    var profileImage: String?
    var description: String?
    var phoneNumber: String?
    var birth: String?
    
    static let `default`: UserInformation = UserInformation()
    
    private init() {}
}
