//
//  RegisterStepOneViewController.swift
//  SignUpFlow
//
//  Created by 김호준 on 2020/12/02.
//

import UIKit

class RegisterStepOneViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private var profileImage: UIImage? {
        didSet {
            profileImageView.image = profileImage
            checkAllField()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkAllField),
                                               name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkAllField),
                                               name: UITextView.textDidChangeNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView(_:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tap)
    }
    
    //MARK: - IBActions
    @IBAction func didTapNextButton(_ sender: UIButton) {
        guard let id = idTextField.text, let password = passwordTextField.text, let profileImage = profileImageView.image,
              let introduce = introduceTextView.text else {
            fatalError("빈칸이 있습니다!")
        }

        let member = MemberList.common
        switch member.addNewMember(id: idTextField.text ?? "") {
        case .success(_):
            member.members[id]?.setPassword(password)
            member.members[id]?.setProfileImage(profileImage)
            member.members[id]?.setIntroduction(introduce)
        case .failure(let message):
            fatalError(message.errorDescription ?? "에러 메시지가 없습니다.")
        }
        NotificationCenter.default.removeObserver(UITextField.textDidChangeNotification)
        NotificationCenter.default.removeObserver(UITextView.textDidChangeNotification)
    }
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        profileImageView.image = nil
        idTextField.text = nil
        passwordTextField.text = nil
        checkPasswordTextField.text = nil
        introduceTextView.text = nil
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterStepOneViewController {
    @objc func didTapProfileImageView(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @objc func checkAllField() {
        let checkTextFields = [idTextField, passwordTextField, checkPasswordTextField].filter { $0?.text == "" }
        let isImageViewNotEmpty = profileImageView.image == nil ? false : true
        let isTextViewNotEmpty = introduceTextView.text == "" ? false : true
        
        if checkTextFields.isEmpty && isImageViewNotEmpty && isTextViewNotEmpty && checkValidatePassword() {
            nextButton.isEnabled = true
        }
        else {
            nextButton.isEnabled = false
        }
    }
    
    private func checkValidatePassword() -> Bool {
        //passwordTextField가 비어있지 않고 서로 같으면
        if (passwordTextField.text != "") && (passwordTextField.text == checkPasswordTextField.text) {
            return true
        }
        return false
    }
    private func configureTextField(_ textField: UITextField) {
        if textField == idTextField {
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .emailAddress
        }
        else if textField == passwordTextField {
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
        }
    }
}

extension RegisterStepOneViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let pickedImage = info[.editedImage] as? UIImage else {
            fatalError("No Image Picked!!")
        }
        self.profileImage = pickedImage
    }
}
