//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by Yeon on 2020/11/30.
//

class UserInformation {
    static let shared: UserInformation = UserInformation()
    private init() {}
    var userID: String?
    var userPassWord: String?
    var userImage: String?
    var userIntroduction: String?
    var userPhone: String?
    var userBirthDate: String?
}
