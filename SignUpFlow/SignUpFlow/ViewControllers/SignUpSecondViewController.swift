//
//  SignUpSecondViewController.swift
//  SignUpFlow
//
//  Created by Kyungmin Lee on 2020/12/02.
//

import UIKit

class SignUpSecondViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Properites
    class var storyboardID: String {
        return "\(self)"
    }

}
