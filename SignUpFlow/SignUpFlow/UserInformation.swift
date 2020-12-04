import UIKit

class UserInformation {
    var id: String?
    var password: String?
    var profileImage: UIImage?
    var selfIntroductionText: String?
    var phoneNumber: String?
    var birth: String?
    
    static let `default`: UserInformation = UserInformation()
    
    private init() {}
}
