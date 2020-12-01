//
//  UserInformation.swift
//  SignUpFlow
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
    var birthDay: String?
}
