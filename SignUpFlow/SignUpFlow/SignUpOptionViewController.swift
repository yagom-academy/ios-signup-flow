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
    var userInfoTemporarySave: UserInfoTemporarySave = UserInfoTemporarySave()
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardDoneButton()
        phoneTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayUserInfo()
        signUpButtonEnableChange()
    }
        
    private func displayUserInfo() {
        if let phone = userInfoTemporarySave.phone {
            phoneTextField.text = phone
        }
        if let date = userInfoTemporarySave.birthDate {
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
        userInfoTemporarySave.birthDate = date
        self.birthDateDisplayLabel.text = dateString
        signUpButtonEnableChange()
    }
    
    @IBAction private func tapGoBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tapCancelButton() {
        userInfoTemporarySave.resetInfo()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tapSignUpButton() {
        UserInformation.shared.image = userInfoTemporarySave.image
        UserInformation.shared.id = userInfoTemporarySave.id
        UserInformation.shared.password = userInfoTemporarySave.id
        UserInformation.shared.introduction = userInfoTemporarySave.introduction
        UserInformation.shared.phone = userInfoTemporarySave.phone
        UserInformation.shared.birthDate = userInfoTemporarySave.birthDate
        userInfoTemporarySave.resetInfo()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func signUpButtonEnableChange() {
        if userInfoTemporarySave.isOptionInfoFilled() {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
}

extension SignUpOptionViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if phoneTextField.hasText {
            if let phone = phoneTextField.text {
                userInfoTemporarySave.phone = phone
            }
        } else {
            userInfoTemporarySave.phone = nil
        }
        
        signUpButtonEnableChange()
    }
}
