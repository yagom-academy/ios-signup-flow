//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by 강인희 on 2020/12/01.
//

import Foundation
import UIKit

class UserInformation {
    static let sharedInstance = UserInformation()
    
    var birthDate: Date?
    var id: String?
    var introduction: String?
    var password: String?
    var phoneNumber: String?
    var profileImage: UIImage?
    
    private init() {}
}
