//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by iluxsm on 2020/12/01.
//

import UIKit

final class UserInformation {
    // 싱글턴 인스턴스  
    static let card = UserInformation()
    
    // 로그인 화면에 필요한 프로퍼티
    var id: String?
    var password: String?
  
    // 과정 1 화면에 추가로 필요한 프로퍼티
    var profileImage: UIImage?
    var introduction: String?
  
    // 과정 2 화면에 필요한 프로퍼티
    var phoneNumber: String?
    var birthDate: Date?
    
    // private로 선언해서 다른곳에서 객체생성이 불가능하게 한다
    private init() {}
  
    func clear() {
        id = nil
        password = nil
        
        profileImage = nil
        introduction = nil
        
        phoneNumber = nil
        birthDate = nil
    }  
}
