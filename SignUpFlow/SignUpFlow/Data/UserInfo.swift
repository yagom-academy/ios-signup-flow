//
//  UserInfo.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/03.
//

import Foundation
import UIKit

class SignUpForm : InfoForm {
    var id: String?
    var checkPassword: String?
    var password: String?
    var image: UIImage?
    var introduction: String?
    
    func isFilled() -> Bool {
        guard let _ = self.image,
              let _ = self.id,
              let validatePassword = self.password,
              let validateCheckPassword = self.checkPassword,
              let _ = self.introduction,
              validatePassword == validateCheckPassword
        else {
            return false
        }
        return true
    }
    
    func clearInfo() {
        self.id = nil
        self.password = nil
        self.checkPassword = nil
        self.image = nil
        self.introduction = nil
    }
    
    func validateInfo() throws -> Bool {
        return false
    }
}
