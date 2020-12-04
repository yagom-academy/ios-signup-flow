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
    
    let numberOfSignUpRequirements = 5
    
    private var verifiedConditions = Set<Int>() {
        didSet {
            if verifiedConditions.count == numberOfSignUpRequirements {
                nextButton.isEnabled = true
            } else {
                nextButton.isEnabled = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableInitialInputStates()
    }
    
    private func disableInitialInputStates() {
        self.nextButton.isEnabled = false
        self.checkPasswordTextField.isEnabled = false
    }
}

