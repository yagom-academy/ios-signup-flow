//
//  UserInformation.swift
//  SignUpFlow
//
//  Created by Yeon on 2020/11/30.
//
import Foundation
import UIKit

final class UserInformation {
    static let shared: UserInformation = UserInformation()
    private init() {}
    var id: String?
    var password: String?
    var image: UIImage?
    var introduction: String?
    var phone: String?
    var birthDate: Date?
}

protocol UserInfoForm {
    var isFilled: Bool { get }
//    func isFilled() -> Bool
    func clearInfo()
    func validateInfo() throws -> Bool
}

protocol InfoForm: UserInfoForm {
    var id: String? { get }
    var password: String? { get }
    var passwordCheck: String? { get }
    var image: UIImage? { get }
    var introduction: String? { get }
}

protocol InfoOptionForm: UserInfoForm {
    var phone: String? { get }
    var birthDate: Date? { get }
}
