//
//  SignUpFlow - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var statusMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        changeLabelText(with: statusMessageLabel, to: .empty)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
            touchUpSignIn(nil)
        }
        return false
    }
    
    @IBAction func touchUpSignIn(_ sender: UIButton?) {
        guard idTextField.isFilled() else {
            changeLabelText(with: statusMessageLabel, to: .enterId)
            return
        }
        
        guard idTextField.isFilled() else {
            changeLabelText(with: statusMessageLabel, to: .enterPassword)
            return
        }
        
        changeLabelText(with: statusMessageLabel, to: .disableSignIn)
    }
    
    func changeLabelText(with label: UILabel, to message: Message) {
        label.text = message.rawValue
    }
}

extension UITextField {
    func isFilled() -> Bool {
        guard let text = self.text else { return false }
        if text.isEmpty { return false }
        return true
    }
}
