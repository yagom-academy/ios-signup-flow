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
    
    @IBAction func tapAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapSignupButton() {
        guard let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") else {
            return
        }
        
        let signUpNavigationController = UINavigationController(rootViewController: signUpViewController)
        signUpNavigationController.modalPresentationStyle = .fullScreen
        self.present(signUpNavigationController, animated: true)
    }
}
