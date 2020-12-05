//
//  SignUpOptionViewController.swift
//  SignUpFlow
//
//  Created by Yeon on 2020/12/02.
//

import UIKit

class SignUpOptionViewController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var birthDateDisplayLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var signUpButton: UIButton!
    var userInfo: UserInfoTemporarySave = UserInfoTemporarySave()
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardDoneButton()
        phoneTextField.delegate = self
        phoneTextField.addTarget(self, action: #selector(SignUpOptionViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        else if  #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .compact
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayUserInfo()
        signUpButtonEnableChange()
    }
        
    private func displayUserInfo() {
        if let phone = userInfo.phone {
            phoneTextField.text = phone
        }
        if let date = userInfo.birthDate {
            birthDateDisplayLabel.text = self.dateFormatter.string(from: date)
        }
    }
    
    private func setKeyboardDoneButton() {
        let toolBarKeyboard = UIToolbar()
        toolBarKeyboard.sizeToFit()
        let btnDoneBar = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonClicked))
        toolBarKeyboard.items = [btnDoneBar]
        toolBarKeyboard.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        phoneTextField.inputAccessoryView = toolBarKeyboard
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction private func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        userInfo.birthDate = date
        self.birthDateDisplayLabel.text = dateString
        signUpButtonEnableChange()
    }
    
    @IBAction private func tapGoBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tapCancelButton() {
        userInfo.reset()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tapSignUpButton() {
        UserInformation.shared.image = userInfo.image
        UserInformation.shared.id = userInfo.id
        UserInformation.shared.password = userInfo.id
        UserInformation.shared.introduction = userInfo.introduction
        UserInformation.shared.phone = userInfo.phone
        UserInformation.shared.birthDate = userInfo.birthDate
        userInfo.reset()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func signUpButtonEnableChange() {
        if userInfo.isOptionInfoFilled() {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
}

extension SignUpOptionViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if phoneTextField.hasText {
            if let phone = phoneTextField.text {
                userInfo.phone = phone
            }
        } else {
            userInfo.phone = nil
        }
        
        signUpButtonEnableChange()
    }
}
