//
//  SignUpForm.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/04.
//

import Foundation
import UIKit

class SignUpForm : InfoForm {
    var id: String?
    var passwordCheck: String?
    var password: String?
    var image: UIImage?
    var introduction: String?
    
    var isFilled: Bool {
        guard let _ = self.image,
              let _ = self.id,
              let validatePassword = self.password,
              let validateCheckPassword = self.passwordCheck,
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
        self.passwordCheck = nil
        self.image = nil
        self.introduction = nil
    }
    
    func validateInfo() throws -> Bool {
        return false
    }
}
