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
    var id: String? { get }
    var password: String? { get }
    var image: UIImage? { get }
    var introduction: String? { get }
}
