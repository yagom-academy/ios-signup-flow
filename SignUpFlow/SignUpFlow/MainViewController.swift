//
//  MainViewController.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/01.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func onClickSignupButton() {
        guard let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") else {
            return
        }
        
        let signUpNavigationController = UINavigationController(rootViewController: signUpViewController)
        signUpNavigationController.modalPresentationStyle = .fullScreen
        self.present(signUpNavigationController, animated: true)
    }
}
