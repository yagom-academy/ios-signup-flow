import Foundation

class UserInformation {
    var id: String?
    var password: String?
    var phoneNumber: String?
    var dateOfBirth: Date?
    var profileImage: String?
    var introduction: String?
    
    static let shared = UserInformation()
    
    private init() {
    }

    func isSame(password: String, checkPassword: String) -> Bool {
        return password == checkPassword
    }
    
    func filterCharacter(phoneNumber: String) -> String {
        if let _ = Int(phoneNumber) {
            return phoneNumber
        } else {
            return phoneNumber.filter { $0.isNumber }
        }
    }
}
