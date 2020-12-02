//
//  SignUpError.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/02.
//

import Foundation

enum SignUpError : Error {
    case getText
    case isNotValidText
    case isNotValidEmail
    case unknown
}

extension SignUpError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .getText:
            return "텍스트를 가져오는데 문제가 있습니다.\n잠시 후 다시 시도해주세요."
        case .isNotValidText:
            return "유효하지 않은 텍스트입니다.\n올바르게 입력해주세요."
        case .isNotValidEmail:
            return "유효하지 않은 이메일 주소입니다.\n올바르게 입력해주세요."
        case .unknown:
            return "알 수 없는 오류가 발생했습니다.\n잠시 후 다시 시도해주세요."
        }
    }
}

