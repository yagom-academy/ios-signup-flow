//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Kyungmin Lee on 2020/12/02.
//

import UIKit

class SignUpFirstViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    private var imagePickerController = UIImagePickerController()
    
    @objc private func setProfileImage() {
        imagePickerController.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(setProfileImage))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
    }

}

//MARK:- Extensions
extension SignUpFirstViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImage.image = selectedImage
            UserInformation.card.profileImage = self.profileImage.image
        }
        dismiss(animated: true, completion: nil)
    }
}
