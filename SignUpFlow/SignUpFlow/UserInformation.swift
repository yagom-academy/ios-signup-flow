import Foundation

struct UserInformation {
    var id: String?
    var password: String?
    var profileImage: String?
    var description: String?
    var phoneNumber: String?
    var birth: String?
}

// sington에 대하여 고민해봅시다.
// pr 보낼때 birth의 경우 연, 월, 일로 구분지어야 하는지 고민.
