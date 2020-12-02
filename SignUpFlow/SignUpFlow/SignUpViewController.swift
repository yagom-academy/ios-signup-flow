//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/01.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction private func tapCancelButton() {
        userInformationReset()
        cancel()
    }
    
    private func userInformationReset() {
        UserInformation.shared.id = nil
        UserInformation.shared.password = nil
        UserInformation.shared.image = nil
        UserInformation.shared.introduction = nil
        UserInformation.shared.phone = nil
        UserInformation.shared.birthDate = nil
    }

    private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
