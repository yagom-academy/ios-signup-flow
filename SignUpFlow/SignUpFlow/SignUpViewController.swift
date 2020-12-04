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

// TODO: 이메일 체킹
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet var profileTextFields: [UITextField]!
    @IBOutlet weak var nextButton: UIButton!
    
    private let profileImagePicker = UIImagePickerController()
    private let introductionPlaceholderMessage = "자기소개를 입력해주세요."
    private let introductionPlaceholderColor = UIColor.lightGray
    private let introductionTextColor = UIColor.black
    
    private(set) var signUpForm = SignUpForm()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpKeyboard()
        setUpProfileImage()
        setUpProfileTextField()
        setUpIntroductionTextView()
    }
    
    // MARK: - settings
    private func setUpNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setUpKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(tapDoneButton(_:)))
        keyboardToolbar.items = [doneButton]
        
        introductionTextView.inputAccessoryView = keyboardToolbar
        for textField in profileTextFields {
            textField.inputAccessoryView = keyboardToolbar
        }
    }
    
    private func setUpProfileImage() {
        let profileImageGesture = UITapGestureRecognizer(target: self, action: #selector(tapProfileImageView(_:)))
        profileImageView.addGestureRecognizer(profileImageGesture)
        
        profileImagePicker.allowsEditing = true
        profileImagePicker.delegate = self
    }
    
    private func setUpProfileTextField() {
        for textField in profileTextFields {
            textField.delegate = self
        }
    }
    
    private func setUpIntroductionTextView() {
        introductionTextView.layer.borderColor = UIColor.lightGray.cgColor
        introductionTextView.delegate = self
        setIntroductionPlaceholder()
    }
    
    @objc func tapDoneButton(_ sender: Any) {
        self.view.endEditing(true)
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
    @IBAction func tapCancelButton(_ sender: Any) {
        self.signUpForm.clearInfo()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setNextButtonState() {
        let isFilledForm = self.signUpForm.isFilled
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
            self.signUpForm.image = profileImage
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
            textView.textColor = UIColor.textViewTextColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let introductionText = textView.text else {
            return self.showError(SignUpError.getText)
        }
        if isValidateText(from: introductionText) {
            self.signUpForm.introduction = introductionText
        } else {
            self.signUpForm.introduction = nil
            setIntroductionPlaceholder()
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
        
        if let textFieldText = textField.text {
            if isValidateText(from: textFieldText) {
                setUserInfoFormData(type: type, text: textFieldText)
            } else {
                setUserInfoFormData(type: type, text: nil)
            }
        }
        
        self.setNextButtonState()
    }
    
    private func setUserInfoFormData(type: ProfileFieldType, text: String?) {
        switch type {
        case .id:
            self.signUpForm.id = text
        case .password:
            self.signUpForm.password = text
        case .checkPassword:
            self.signUpForm.passwordCheck = text
        }
    }
}
