//
//  FirstSignUpViewController.swift
//  SignUpFlow
//
//  Created by Jinho Choi on 2020/12/01.
//

import UIKit

class FirstSignUpViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var newIdTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let numberOfSignUpRequirements = 5
    
    private var verifiedConditions = Set<Int>() {
        didSet {
            if verifiedConditions.count == numberOfSignUpRequirements {
                nextButton.isEnabled = true
            } else {
                nextButton.isEnabled = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableInitialInputStates()
        initializeImagePicker()
    }
    
    private func disableInitialInputStates() {
        self.nextButton.isEnabled = false
        self.checkPasswordTextField.isEnabled = false
    }
    
    private func initializeImagePicker() {
        let profileImageTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(pickProfileImage))
        profileImageView.addGestureRecognizer(profileImageTapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    @IBAction func verifyIdField(_ sender: UITextField) {
        if sender.text?.isEmpty ?? true {
            guard verifiedConditions.contains(sender.tag) else {
                return
            }
            verifiedConditions.remove(sender.tag)
        } else {
            verifiedConditions.insert(sender.tag)
        }
    }
    
    @IBAction func verifyPasswordField(_ sender: UITextField) {
        if sender.text?.isEmpty ?? true {
            guard verifiedConditions.contains(sender.tag) else {
                return
            }
            verifiedConditions.remove(sender.tag)
            self.checkPasswordTextField.text = ""
            self.checkPasswordTextField.isEnabled = false
        } else {
            verifiedConditions.insert(sender.tag)
            self.checkPasswordTextField.isEnabled = true
        }
    }
    
    
    @IBAction func verifyCheckPasswordField(_ sender: UITextField) {
        guard let writtenPassword = self.newPasswordTextField.text, let checkingPassword = sender.text else {
            return
        }
        guard writtenPassword == checkingPassword else {
            guard verifiedConditions.contains(sender.tag) else {
                return
            }
            verifiedConditions.remove(sender.tag)
            return
        }
        verifiedConditions.insert(sender.tag)
    }
    
}
extension FirstSignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func pickProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        self.present(imagePickerController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = (info[.editedImage] ?? info[.originalImage]) as? UIImage else {
            return
        }
        
        self.profileImageView.image = selectedImage
        user.profileImage = selectedImage
        
        let imageTag = self.profileImageView.tag
        
        if self.profileImageView.image != nil {
            verifiedConditions.insert(imageTag)
        } else {
            guard verifiedConditions.contains(imageTag) else {
                return
            }
            verifiedConditions.remove(imageTag)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

