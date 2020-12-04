//
//  RegisterStepOneViewController.swift
//  SignUpFlow
//
//  Created by 김호준 on 2020/12/02.
//

import UIKit

class RegisterStepOneViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView(_:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tap)
    }
    
    //MARK: - IBActions
    @IBAction func didTapNextButton(_ sender: UIButton) {
//        프로필 이미지, 아이디, 자기소개가 모두 채워지고,
//        패스워드가 일치하면 '다음' 버튼이 활성화됩니다.
        

    }
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        profileImageView.image = nil
        idTextField.text = nil
        passwordTextField.text = nil
        checkPasswordTextField.text = nil
        introduceTextView.text = nil
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterStepOneViewController {
    @objc func didTapProfileImageView(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

extension RegisterStepOneViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let pickedImage = info[.editedImage] as? UIImage else {
            fatalError("No Image Picked!!")
        }
        self.profileImageView.image = pickedImage
    }
}
