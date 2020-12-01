//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by Kyungmin Lee on 2020/12/01.
//

import Foundation

class UserInformation {
    // 싱글턴 인스턴스
    static let shared: UserInformation = UserInformation()
    
    // private로 선언해서 다른곳에서 객체생성이 불가능하게 한다
    private init() {}
}
