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
    let userInfoTemporarySave = UserInfoTemporarySave()
    
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
        userInfoTemporarySave.resetInfo()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func isPasswordMatch() -> Bool {
        if passwordTextField.text! == passwordCheckTextField.text! {
            return true
        }
        return false
    }
    
    func goNextButtonEnableChange() {
        if userInfoTemporarySave.isSignUpViewFilled() && isPasswordMatch() {
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
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction private func tapGoNextButton() {
        let signUpOptionVC = SignUpOptionViewController(nibName: "SignUpOption", bundle: nil)
        signUpOptionVC.userInfoTemporarySave = self.userInfoTemporarySave
        
        guard let signUpOptionViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpOption") else {
            return
        }
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
            userInfoTemporarySave.image = editedImage
        }
        goNextButtonEnableChange()
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if idTextField.hasText {
            if let id = idTextField.text {
                userInfoTemporarySave.id = id
            }
        } else {
            userInfoTemporarySave.id = nil
        }
        
        if passwordTextField.hasText {
            if let password = passwordTextField.text {
                userInfoTemporarySave.password = password
            }
        } else {
            userInfoTemporarySave.password = nil
        }
        
        if passwordCheckTextField.hasText {
            if let passwordCheck = passwordCheckTextField.text {
                userInfoTemporarySave.passwordCheck = passwordCheck
            }
        } else {
            userInfoTemporarySave.passwordCheck = nil
        }
        
        goNextButtonEnableChange()
    }
}

extension SignUpViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if introductionTextView.hasText {
            if let introduction = introductionTextView.text {
                userInfoTemporarySave.introduction = introduction
            }
        } else {
            userInfoTemporarySave.introduction = nil
        }
        
        goNextButtonEnableChange()
    }
}

