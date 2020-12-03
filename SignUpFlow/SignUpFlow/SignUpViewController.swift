//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/01.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate,
                            UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var goNextButton: UIButton!
    let checkFilled = UserInfoTemporarySave()
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editedImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = editedImage
        self.dismiss(animated: true, completion: nil)
        checkFilled.image = editedImage
        goNextButtonEnableChange()
    }
    
    @objc func tapImageView(_ gesture: UITapGestureRecognizer) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImageView(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
        introductionTextView.delegate = self
        setKeyboardDoneButton()
    }
    
    @IBAction private func tapCancelButton() {
        cancel()
        checkFilled.resetInfo()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if idTextField.hasText {
            guard let id = idTextField.text else { return }
            checkFilled.id = id
        } else {
            checkFilled.id = nil
        }
        
        if passwordTextField.hasText {
            guard let password = passwordTextField.text else { return }
            checkFilled.password = password
        } else {
            checkFilled.password = nil
        }
        
        if passwordCheckTextField.hasText {
            guard let passwordCheck = passwordCheckTextField.text else { return }
            checkFilled.passwordCheck = passwordCheck
        } else {
            checkFilled.passwordCheck = nil
        }
        
        goNextButtonEnableChange()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if introductionTextView.hasText {
            guard let introduction = introductionTextView.text else { return }
            checkFilled.introduction = introduction
        } else {
            checkFilled.introduction = nil
        }
        
        goNextButtonEnableChange()
    }
    
    private func isPasswordMatch() -> Bool {
        if passwordTextField.text! == passwordCheckTextField.text! {
            return true
        }
        return false
    }
    
    func goNextButtonEnableChange() {
        if checkFilled.isSignUpViewFilled() && isPasswordMatch() {
            goNextButton.isEnabled = true
        }
        else {
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

    private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tapGoNextButton() {
        guard let signUpOptionViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpOption") else {
            return
        }
        
        signUpOptionViewController.modalPresentationStyle = .fullScreen
        self.present(signUpOptionViewController, animated: true)
    }
}
