//
//  UIViewControllerExtension.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/02.
//

import Foundation
import UIKit

extension UIViewController {
    func errorAlert(_ error: Error) -> UIAlertController {
        var errorMessgae: String?
        if let signUpError = error as? SignUpError {
            errorMessgae = signUpError.localizedDescription
        }
        else {
            errorMessgae = SignUpError.unknown.localizedDescription
        }
        
        let alert = UIAlertController(title: "오류", message: errorMessgae, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}
