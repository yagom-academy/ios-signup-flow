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
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = selectedImage
            // 원본 비율 유지하면서 꽉 차게하는 임시 코드. 이건 아까 스토리보드에서 설정하지 않아서 나중에 옮겨 놓을거예요!
            profileImage.contentMode = .scaleAspectFill
            UserInformation.card.profileImage = self.profileImage.image
        }
        dismiss(animated: true, completion: nil)
    }
}
