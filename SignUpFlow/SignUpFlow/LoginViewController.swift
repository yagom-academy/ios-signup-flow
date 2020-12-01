//
//  LoginViewController.swift
//  SignUpFlow
//
//  Created by Jinho Choi on 2020/12/01.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func touchUpSignUpButton(_ sender: Any) {
        guard let targetController = self.storyboard?.instantiateViewController(identifier: "FirstSignUpViewController") else {
            print("targetController 할당에 문제가 있습니다.")
            return
        }
        targetController.modalPresentationStyle = .fullScreen
        self.present(targetController, animated: true, completion: nil)
    }
}
