//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/01.
//

import UIKit

class SignUpViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var goNextButton: UIButton!
    let userInfo = UserInfoTemporarySave()
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
        introductionTextView.delegate = self
        idTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordCheckTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        setTapGesture()
        setKeyboardDoneButton()
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImageView(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func tapImageView(_ gesture: UITapGestureRecognizer) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction private func tapCancelButton() {
        userInfo.reset()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func isPasswordMatch() -> Bool {
        if passwordTextField.text! == passwordCheckTextField.text! {
            return true
        }
        return false
    }
    
    func goNextButtonEnableChange() {
        if userInfo.isSignUpViewFilled() && isPasswordMatch() {
            goNextButton.isEnabled = true
        } else {
            goNextButton.isEnabled = false
        }
    }
    
    func setKeyboardDoneButton() {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let btnDoneBar = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonClicked))
        toolBarKeyboard.items = [btnDoneBar]
        toolBarKeyboard.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        idTextField.inputAccessoryView = toolBarKeyboard
        passwordTextField.inputAccessoryView = toolBarKeyboard
        passwordCheckTextField.inputAccessoryView = toolBarKeyboard
        introductionTextView.inputAccessoryView = toolBarKeyboard
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction private func tapGoNextButton() {
        guard let signUpOptionViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpOption") as? SignUpOptionViewController else {
            return
        }
        signUpOptionViewController.userInfo = self.userInfo
        signUpOptionViewController.modalPresentationStyle = .fullScreen
        self.present(signUpOptionViewController, animated: true)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = editedImage
            userInfo.image = editedImage
        }
        goNextButtonEnableChange()
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if idTextField.hasText {
            if let id = idTextField.text {
                userInfo.id = id
            }
        } else {
            userInfo.id = nil
        }
        
        if passwordTextField.hasText {
            if let password = passwordTextField.text {
                userInfo.password = password
            }
        } else {
            userInfo.password = nil
        }
        
        if passwordCheckTextField.hasText {
            if let passwordCheck = passwordCheckTextField.text {
                userInfo.passwordCheck = passwordCheck
            }
        } else {
            userInfo.passwordCheck = nil
        }
        
        goNextButtonEnableChange()
    }
}

extension SignUpViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if introductionTextView.hasText {
            if let introduction = introductionTextView.text {
                userInfo.introduction = introduction
            }
        } else {
            userInfo.introduction = nil
        }
        
        goNextButtonEnableChange()
    }
}

