//
//  SignUpFlow - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextFieldConfig(passwordTextField)

    }
    
    @IBAction func tapView(_ sender: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    private func passwordTextFieldConfig(_ textField: UITextField) {
        textField.autocorrectionType = .no
    }

}

