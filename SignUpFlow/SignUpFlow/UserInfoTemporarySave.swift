//
//  UserInfomationTemporarySave.swift
//  SignUpFlow
//
//  Created by Yeon on 2020/12/03.
//

import UIKit

class UserInfoTemporarySave {
    var id: String?
    var password: String?
    var passwordCheck: String?
    var image: UIImage?
    var introduction: String?
    var phone: String?
    var birthDate: Date?
    
    func isSignUpViewFilled() -> Bool {
        guard let _ = self.id,
              let _ = self.password,
              let _ = self.passwordCheck,
              let _ = self.image,
              let _ = self.introduction else {
            return false
        }
        return true
    }
    
    func isOptionInfoFilled() -> Bool {
        guard let _ = self.birthDate,
              let _ = self.phone else {
            return false
        }
        return true
    }
    
    func resetInfo() {
        self.id = nil
        self.password = nil
        self.passwordCheck = nil
        self.image = nil
        self.introduction = nil
        self.phone = nil
        self.birthDate = nil
    }
}
