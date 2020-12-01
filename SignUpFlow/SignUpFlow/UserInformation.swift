//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by 김태형 on 2020/12/01.
//

import UIKit

class UserInformation {
    
    let id: String?
    private(set) var password: String?
    private(set) var profileImage: UIImage?
    private(set) var introduction: String?
    private(set) var phoneNumber: String?
    private(set) var dateOfBirth: Date?
    
    init (_ id: String) {
        self.id = id
    }
    
    func setPassword(_ password: String) {
        self.password = password
    }
    
    func setProfileImage(_ profileImage: UIImage) {
        self.profileImage = profileImage
    }
    
    func setIntroduction(_ introduction: String) {
        self.introduction = introduction
    }
    
    func setPhoneNumber(_ phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    func setDateOfBirth(_ dateOfBirth: Date) {
        self.dateOfBirth = dateOfBirth
    }
}
