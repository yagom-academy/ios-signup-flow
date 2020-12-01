//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by iluxsm on 2020/12/01.
//

import UIKit

final class UserInformation {
    static let card = UserInformation()
    
    var id: String?
    var password: String?
    var profileImage: UIImage?
    var introduction: String?
    var phoneNumber: String?
    var birthDate: Date?
    
    private init() {}
}
