//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/01.
//

import UIKit

enum ProfileFieldType: Int, CaseIterable {
    case id = 1
    case password
    case checkPassword
}

class UserInfo : InfoForm {
    var id: String?
    var checkPassword: String?
    var password: String?
    var image: UIImage?
    var introduction: String?
    
    func isFilled() -> Bool {
        guard let _ = self.image,
              let _ = self.id,
              let validatePassword = self.password,
              let validateCheckPassword = self.checkPassword,
              let _ = self.introduction,
              validatePassword == validateCheckPassword
        else {
            return false
        }
        return true
    }
    
    func clearInfo() {
        self.id = nil
        self.password = nil
        self.checkPassword = nil
        self.image = nil
        self.introduction = nil
    }
    
    func validateInfo() throws -> Bool {
        return false
    }
}

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet var profileTextFields: [UITextField]!
    @IBOutlet weak var nextButton: UIButton!
    
    private let profileImagePicker = UIImagePickerController()
    private let introductionPlaceholderMessage = "자기소개를 입력해주세요."
    private let introductionPlaceholderColor = UIColor.lightGray
    private let introductionTextColor = UIColor.black
    
    private(set) var userInfoForm = UserInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboard()
        setProfileImage()
        setProfileTextField()
        setIntroductionTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - settings
    private func setKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(tapDoneButton(_:)))
        keyboardToolbar.items = [doneButton]
        
        introductionTextView.inputAccessoryView = keyboardToolbar
        for textField in profileTextFields {
            textField.inputAccessoryView = keyboardToolbar
        }
    }
    
    @objc func tapDoneButton(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    private func setProfileImage() {
        let profileImageGesture = UITapGestureRecognizer(target: self, action: #selector(tapProfileImageView(_:)))
        profileImageView.addGestureRecognizer(profileImageGesture)
        
        profileImagePicker.allowsEditing = true
        profileImagePicker.delegate = self
    }
    
    private func setProfileTextField() {
        for textField in profileTextFields {
            textField.delegate = self
        }
    }
    
    private func setIntroductionTextView() {
        introductionTextView.layer.borderColor = UIColor.lightGray.cgColor
        introductionTextView.delegate = self
        setIntroductionPlaceholder()
    }
    
    // MARK: - Profile Image func
    @objc func tapProfileImageView(_ sender: UITapGestureRecognizer) {
        let profileImageAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let openAlbum = UIAlertAction(title: "앨범에서 가져오기", style: .default) { _ in
            self.openAlbum()
        }
        let openCamera = UIAlertAction(title: "카메라로 찍기", style: .default) { _ in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        profileImageAlert.addAction(openAlbum)
        profileImageAlert.addAction(openCamera)
        profileImageAlert.addAction(cancel)
        
        self.present(profileImageAlert, animated: true, completion: nil)
    }
    
    private func openAlbum() {
        profileImagePicker.sourceType = .photoLibrary
        present(profileImagePicker, animated: false, completion: nil)
    }
    
    private func openCamera() {
        profileImagePicker.sourceType = .camera
        present(profileImagePicker, animated: false, completion: nil)
    }
    
    // MARK: - Step Buttons
    @IBAction func tapCancleButton(_ sender: Any) {
        profileImageView.image = nil
        for textField in profileTextFields {
            textField.text = nil
        }
        setIntroductionPlaceholder()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setNextButtonState() {
        let isFilledForm = self.userInfoForm.isFilled()
        if isFilledForm != self.nextButton.isEnabled {
            self.nextButton.isEnabled = isFilledForm
        }
    }
    
    @IBAction func tapNextButton(_ sender: Any) {
        guard let signUpOptionViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpOption") else {
            return
        }
        self.navigationController?.pushViewController(signUpOptionViewController, animated: true)
    }
    
    // MARK: - check form
    private func isValidateText(from checkText: String) -> Bool {
        if checkText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    // MARK: - alert func
    private func showError(_ error: Error) {
        self.present(self.errorAlert(error), animated: true, completion: nil)
    }
}

// MARK: - extensions
extension SignUpViewController : UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let profileImage = info[.editedImage] as? UIImage {
            self.profileImageView.image = profileImage
            self.userInfoForm.image = profileImage
        }
        self.setNextButtonState()
        dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController : UITextViewDelegate {
    func setIntroductionPlaceholder() {
        introductionTextView.text = self.introductionPlaceholderMessage
        introductionTextView.textColor = self.introductionPlaceholderColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == self.introductionPlaceholderColor {
            textView.text = nil
            textView.textColor = UIColor.textViewColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let introductionText = textView.text else {
            return self.showError(SignUpError.getText)
        }
        if isValidateText(from: introductionText) {
            self.userInfoForm.introduction = introductionText
        } else {
            self.userInfoForm.introduction = nil
            textView.text = self.introductionPlaceholderMessage
            textView.textColor = self.introductionPlaceholderColor
        }
        self.setNextButtonState()
    }
}

extension SignUpViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moveNextTextField(from: textField)
        return true
    }
    
    private func moveNextTextField(from textField: UITextField) {
        let nextTag = textField.tag + 1
        if nextTag <= self.profileTextFields.count {
            let field = profileTextFields.first(where: { $0.tag == nextTag })
            field?.becomeFirstResponder()
        }
        else {
            self.introductionTextView.becomeFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let type = ProfileFieldType(rawValue: textField.tag) else {
            return self.showError(SignUpError.unknown)
        }
        
        switch type {
        case .id:
            self.userInfoForm.id = textField.text
        case .password:
            self.userInfoForm.password = textField.text
        case .checkPassword:
            self.userInfoForm.checkPassword = textField.text
        }
        
        self.setNextButtonState()
    }
}
