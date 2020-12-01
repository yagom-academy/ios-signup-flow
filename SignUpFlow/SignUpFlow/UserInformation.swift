import UIKit

final class UserInformation {
    private struct User {
        var id: String?
        var password: String?
        var image: UIImage?
        var introduction: String?
        var phoneNumber: String?
        var birthday: Date?
    }
    
    private var user: User
    
    static let userCommon = UserInformation()
    
    private init() {
        user = User()
    }
    
    func setId(id: String) {
        user.id = id
    }
    
    func setPassword(pasword: String) {
        user.password = pasword
    }
    
    func setImage(image: UIImage) {
        user.image = image
    }
    
    func setIntroduction(introduction: String) {
        user.introduction = introduction
    }
    
    func setPhoneNumber(phoneNumber: String) {
        user.phoneNumber = phoneNumber
    }
    
    func setBirthday(birthday: Date) {
        user.birthday = birthday
    }
}
