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
    var userInfoTemporarySave: UserInfoTemporarySave = UserInfoTemporarySave()
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayUserInfo()
    }
        
    private func displayUserInfo() {
        phoneTextField.text = userInfoTemporarySave.phone
        if let dateString = userInfoTemporarySave.birthDate {
            birthDateDisplayLabel.text = self.dateFormatter.string(from: dateString)
        }
    }
    
    @IBAction private func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        userInfoTemporarySave.birthDate = date
        self.birthDateDisplayLabel.text = dateString
    }
    
    @IBAction func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
