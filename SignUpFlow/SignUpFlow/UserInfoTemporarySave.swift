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
        if self.id?.isEmpty != nil && self.password?.isEmpty != nil && self.passwordCheck?.isEmpty != nil &&
            self.image != nil && self.introduction?.isEmpty != nil {
            return true
        }
        return false
    }
    
    func isAllInfoFilled() -> Bool {
        if self.isSignUpViewFilled() && self.birthDate?.description.isEmpty != nil && self.phone?.isEmpty != nil {
            return true
        }
        return false
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
