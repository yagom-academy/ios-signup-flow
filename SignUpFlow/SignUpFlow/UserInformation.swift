import Foundation

class UserInformation {
    let id: String
    fileprivate(set) var password: String
    fileprivate(set) var phoneNumber: String
    fileprivate(set) var dateOfBirth: Date
    fileprivate(set) var profileImage: String
    fileprivate(set) var introduction: String
    
    static var `default`: UserInformation?
    
    init(id: String, password: String, phoneNumber: String, dateOfBirth: Date, profileImage: String, introduction: String) {
        self.id = id
        self.password = password
        self.phoneNumber = phoneNumber
        self.dateOfBirth = dateOfBirth
        self.profileImage = profileImage
        self.introduction = introduction
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



