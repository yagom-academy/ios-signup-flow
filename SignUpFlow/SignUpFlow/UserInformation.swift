//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by Yeon on 2020/11/30.
//
import Foundation

class UserInformation {
    static let shared: UserInformation = UserInformation()
    private init() {}
    var id: String?
    var password: String?
    var imagePath: String?
    var introduction: String?
    var phone: String?
    var birthDate: Date?
}
