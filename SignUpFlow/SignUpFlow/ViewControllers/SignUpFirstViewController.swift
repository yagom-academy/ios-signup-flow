//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Kyungmin Lee on 2020/12/02.
//

import UIKit

class SignUpFirstViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    // MARK: - Properties
    private var imagePickerController = UIImagePickerController()
  
    private var isValidID: Bool {
        guard let id = idTextField.text else {
            return false
        }

        if id.isEmpty || id.contains(" ") {
            print("ID가 유효하지 않음")
            return false
        }
        
        return true
    }
    
    private var isValidPassword: Bool {
        guard let password = passwordTextField.text,
              let checkPassword = checkPasswordTextField.text else {
            return false
        }

        if password.isEmpty || password.contains(" ") || password != checkPassword {
            print("Password가 유효하지 않음")
            return false
        }
 
        return true
    }
    
    private var isValidIntroduction: Bool {
        guard let introduction = introductionTextView.text else {
            return false
        }
        
        if introduction.isEmpty {
            print("Introduction이 유효하지 않음")
            return false
        }
        
        return true
    }
    
    private var isValidProfileImage: Bool {
        if let _ = profileImage.image {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        setupTextView()
        setupImagePicker()
    }
}

// MARK: - IBActions & Methods
extension SignUpFirstViewController {
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        clearUserInformation()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpNextButton(_ sender: UIButton) {
        saveUserInformation()
        
        // 다음 화면으로 이동
        guard let signUpSecondViewController = storyboard?.instantiateViewController(withIdentifier: SignUpSecondViewController.storyboardID) as? SignUpSecondViewController else {
            return
        }
        
        navigationController?.pushViewController(signUpSecondViewController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    private func saveUserInformation() {
        let card = UserInformation.card
        
        card.id = idTextField.text
        card.password = passwordTextField.text
        card.introduction = introductionTextView.text
        card.profileImage = profileImage.image
    }
    
    private func clearUserInformation() {
        UserInformation.card.clear()
    }
    
    private func checkToEnableNextButton() {
        guard isValidID, isValidPassword, isValidIntroduction, isValidProfileImage else {
            nextButton.isEnabled = false
            return
        }
        
        nextButton.isEnabled = true
    }
  
    @objc private func showImagePicker() {
        imagePickerController.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate Methods
extension SignUpFirstViewController: UITextFieldDelegate {
    private func setupTextField() {
        idTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 리턴 키 누르면 다음 텍스트필드로 커서 이동
        switch textField {
        case idTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            checkPasswordTextField.becomeFirstResponder()
        case checkPasswordTextField:
            // 비밀번호 확인 텍스트필드 입력 후에는 자기소개 텍스트뷰로 커서 이동
            introductionTextView.becomeFirstResponder()
        default: break
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkToEnableNextButton()
    }
}

// MARK: - UITextViewDelegate Methods
extension SignUpFirstViewController: UITextViewDelegate {
    private func setupTextView() {
        introductionTextView.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        checkToEnableNextButton()
    }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate Methods
extension SignUpFirstViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func setupImagePicker() {
        imagePickerController.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showImagePicker))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImage.image = selectedImage
        }
        
        checkToEnableNextButton()
        
        dismiss(animated: true, completion: nil)
    }
}
