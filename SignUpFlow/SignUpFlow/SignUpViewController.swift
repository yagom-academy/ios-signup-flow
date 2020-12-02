//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/01.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    private let profileImagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setProfileImage() {
        let profileImageGesture = UITapGestureRecognizer(target: self, action: #selector(tapProfileImageView(_:)))
        profileImage.addGestureRecognizer(profileImageGesture)
        
        profileImagePicker.delegate = self
    }
    
    @objc func tapProfileImageView(_ sender: UITapGestureRecognizer) {
        let profileImageAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let openAlbum = UIAlertAction(title: "앨범에서 가져오기", style: .default) { _ in
            self.openAlbum()
        }
        let openCamera = UIAlertAction(title: "카메라로 찍기", style: .default) { _ in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        profileImageAlert.addAction(openAlbum)
        profileImageAlert.addAction(openCamera)
        profileImageAlert.addAction(cancel)
        
        self.present(profileImageAlert, animated: true, completion: nil)
    }
    
    private func openAlbum() {
        
    }
    
    private func openCamera() {
        
    }
}

extension SignUpViewController : UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
    
}
