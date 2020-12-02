//
//  FirstSignUpViewController.swift
//  SignUpFlow
//
//  Created by Jinho Choi on 2020/12/01.
//

import UIKit

class FirstSignUpViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var newIdTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.isEnabled = false
    }
}
