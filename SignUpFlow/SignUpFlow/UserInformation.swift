import UIKit

///Type Property : form / 유저 정보에 관한 타입.
class UserInformation {
    static let form = UserInformation()
    
    private init() {}
    
    //User라면 공통적으로 가지고 있어야 할 프로퍼티.
    var id: String?
    var password: String?
    var profileImage: UIImage?
    var introduce: String?
    var phoneNumber: String?
    var birth: Date?
}
