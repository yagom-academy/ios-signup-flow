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
    
    @IBAction func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
