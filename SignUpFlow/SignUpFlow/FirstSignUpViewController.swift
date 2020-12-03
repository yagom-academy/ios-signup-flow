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
//        self.nextButton.isEnabled = false
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        UserInformation.common.resetInformation()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpNextButton(_ sender: UIButton) {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondSignUpViewController") else {
            return
        }
        setUserInfomation()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    private func setUserInfomation() {
        UserInformation.common.profileImage = self.profileImageView.image
        UserInformation.common.id = self.newIdTextField.text
        UserInformation.common.password = self.newPasswordTextField.text
        UserInformation.common.introduction = self.introductionTextView.text
    }
}
