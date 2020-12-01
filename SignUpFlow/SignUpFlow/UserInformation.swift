//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by 강인희 on 2020/12/01.
//
import UIKit
import Foundation

class UserInformation {
    static let common: UserInformation = UserInformation()

    private init() { }

    var id: String?
    var password: String?
    var profileImage: UIImage?
    var introduction: String?
    var phoneNumber: String?
    var birthDay: Date?
}
