//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/01.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var introductionTextView: UITextView!
    
    private let profileImagePicker = UIImagePickerController()
    private let introductionPlaceholderMessage = "자기소개를 입력해주세요."
    private let introductionPlaceholderColor = UIColor.lightGray
    private let introductionTextColor = UIColor.black

    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileImage()
        setIntroductionTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setProfileImage() {
        let profileImageGesture = UITapGestureRecognizer(target: self, action: #selector(tapProfileImageView(_:)))
        profileImageView.addGestureRecognizer(profileImageGesture)
        
        profileImagePicker.allowsEditing = true
        profileImagePicker.delegate = self
    }
    
    private func setIntroductionTextView() {
        introductionTextView.delegate = self
        setPlaceholder()
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
        profileImagePicker.sourceType = .photoLibrary
        present(profileImagePicker, animated: false, completion: nil)
    }
    
    private func openCamera() {
        profileImagePicker.sourceType = .camera
        present(profileImagePicker, animated: false, completion: nil)
    }
}

extension SignUpViewController : UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let profileImage = info[.editedImage] as? UIImage {
            self.profileImageView.image = profileImage
        }
        dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController : UITextViewDelegate {
    func setPlaceholder() {
        introductionTextView.text = self.introductionPlaceholderMessage
        introductionTextView.textColor = self.introductionPlaceholderColor
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == self.introductionPlaceholderColor {
            textView.text = nil
            textView.textColor = self.introductionTextColor
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = self.introductionPlaceholderMessage
            textView.textColor = self.introductionPlaceholderColor
        }
    }
}
