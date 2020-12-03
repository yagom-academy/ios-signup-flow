//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Kyungmin Lee on 2020/12/02.
//

import UIKit

class SignUpFirstViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
    }
}

// MARK: - IBActions & Methods
extension SignUpFirstViewController {
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        clearUserInformation()
        
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    func clearUserInformation() {
        UserInformation.card.clear()
    }
}

// MARK: - UITextFieldDelegate Methods
extension SignUpFirstViewController: UITextFieldDelegate {
    private func setupTextField() {
        idTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
    }
}
