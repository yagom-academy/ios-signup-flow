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
        initializeImagePicker()
        checkTextFields()
        introductionTextView.delegate = self
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func initializeImagePicker() {
        let profileImageTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(pickProfileImage))
        profileImageView.addGestureRecognizer(profileImageTapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        user.resetInformation()
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
        user.profileImage = self.profileImageView.image
        user.id = self.newIdTextField.text
        user.password = self.newPasswordTextField.text
        user.introduction = self.introductionTextView.text
    }
    
    func checkTextFields() {
        [newIdTextField, newPasswordTextField, checkPasswordTextField].forEach {
            $0.addTarget(self, action: #selector(checkAllRequirementsAreFilled), for: .editingChanged)
        }
    }
    
    @objc private func checkAllRequirementsAreFilled() {
        guard let id = newIdTextField.text, !id.isEmpty,
              let password = newPasswordTextField.text, !password.isEmpty,
              let checkPassword = checkPasswordTextField.text, !checkPassword.isEmpty,
              password == checkPassword,
              let textView = introductionTextView.text, !textView.isEmpty,
              profileImageView.image != nil else {
            nextButton.isEnabled = false
            return
        }
        nextButton.isEnabled = true
    }
}

extension FirstSignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func pickProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        self.present(imagePickerController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = (info[.editedImage] ?? info[.originalImage]) as? UIImage else {
            return
        }
        self.profileImageView.image = selectedImage
        checkAllRequirementsAreFilled()
        self.dismiss(animated: true, completion: nil)
    }
}

extension FirstSignUpViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkAllRequirementsAreFilled()
    }
}
