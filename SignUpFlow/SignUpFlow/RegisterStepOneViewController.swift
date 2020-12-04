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
    }
    @IBAction func didTapCancelButton(_ sender: UIButton) {
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
