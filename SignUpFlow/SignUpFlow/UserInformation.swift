import Foundation
import UIKit

class UserInformation {
    static let shared = UserInformation()
    
    private init() {
    }
    
    var id: String?
    var password: String?
    var phoneNumber: String?
    var birthDate: Date?
    var profileImage: UIImage?
    var introduction: String?
}
