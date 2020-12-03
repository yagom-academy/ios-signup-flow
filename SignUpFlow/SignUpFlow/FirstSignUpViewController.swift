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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.isEnabled = false
        
        let profileImageTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(pickProfileImage))
        profileImageView.addGestureRecognizer(profileImageTapGesture)
        profileImageView.isUserInteractionEnabled = true
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
        
        if let selectedImage = info[.editedImage] as? UIImage {
            self.profileImageView.image = selectedImage
            user.profileImage = selectedImage
        } else if let selectedImage = info[.originalImage] as? UIImage {
            self.profileImageView.image = selectedImage
            user.profileImage = selectedImage
        }

        self.dismiss(animated: true, completion: nil)
    }
}
