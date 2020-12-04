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
    
    private let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        // 날짜 형식 "November 18, 2020"
        formatter.dateStyle = .long
        
        return formatter
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDatePicker()
    }
}

// MARK: - UIDatePicker Methods
extension SignUpSecondViewController {
    func setupDatePicker() {
        datePicker.addTarget(self, action: #selector(didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        datePicker.maximumDate = Date()
        
        updateDateLabelFromDatePicker(datePicker)
    }
    
    @objc func didDatePickerValueChanged(_ sender: UIDatePicker) {
        updateDateLabelFromDatePicker(sender)
        
        // 가입 버튼 활성화 조건 확인 추가하기
    }
    
    func updateDateLabelFromDatePicker(_ sender: UIDatePicker) {
        let date: Date = sender.date
        let dateString: String = dateFormatter.string(from: date)
        
        birthDateLabel.text = dateString
    }
}
