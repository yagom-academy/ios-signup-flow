//
//  SignUpViewController.swift
//  SignUpFlow
//
//  Created by Wonhee on 2020/12/01.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editedImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        UserInformation.shared.image = editedImage
        self.imageView.image = editedImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapImageView(_ gesture: UITapGestureRecognizer) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImageView(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction private func tapCancelButton() {
        userInformationReset()
        cancel()
    }
    
    private func userInformationReset() {
        UserInformation.shared.id = nil
        UserInformation.shared.password = nil
        UserInformation.shared.image = nil
        UserInformation.shared.introduction = nil
        UserInformation.shared.phone = nil
        UserInformation.shared.birthDate = nil
    }

    private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
