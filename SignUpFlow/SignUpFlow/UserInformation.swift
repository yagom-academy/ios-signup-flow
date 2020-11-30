//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by Jinho Choi on 2020/11/30.
//
import UIKit
import Foundation

class UserInformation {
    static let approached: UserInformation = UserInformation()
    
    private init() { }
    
    var userId: String?
    var userPassword: String?
    var userCheckPassword: String?
    var userImage: UIImage?
    var userIntroduction: String?
    var userPhoneNumber: String?
    var userBirthDay: String?
}
