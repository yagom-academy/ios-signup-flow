//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/01.
//

import UIKit
// TODO: 취소 버튼 클릭 -> 지원 정보 지워지고 -> 로그인 화면으로 돌아가기
// TODO: 모든 필드 채워지고, 비밀번호-비밀번호 확인 일치하면 다음 활성화
// TODO: 필드 return(next) 클릭시 다음 필드로 넘어가기
// TODO: 키보드 위에 악세서리 뷰 붙여서 키보드 내릴 수 있게?
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var introductionTextView: UITextView!
    
    private let profileImagePicker = UIImagePickerController()
    private let introductionPlaceholderMessage = "자기소개를 입력해주세요."
    private let introductionPlaceholderColor = UIColor.lightGray
    private let introductionTextColor = UIColor.black

    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboard()
        setProfileImage()
        setIntroductionTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(tapDoneButton(_:)))
        keyboardToolbar.items = [doneButton]
        
        introductionTextView.inputAccessoryView = keyboardToolbar
    }
    
    @objc func tapDoneButton(_ sender: Any) {
        self.view.endEditing(true)
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
    
    @IBAction func tapCancleButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapNextButton(_ sender: Any) {
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
