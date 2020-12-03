import UIKit
import MobileCoreServices

class SignUpStep1ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    private let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hasValue(_ uiView: UIView?) -> Bool {
        switch uiView {
        case let imageView as UIImageView:
            if imageView.image == nil {
                return false
            }
        case let textField as UITextField:
            return textField.hasText
        case let textView as UITextView:
            return textView.hasText
        default:
            return true
        }
        
        return true
    }
    
    func verifyAllComponentHasValue() -> Bool {
        let allComponent = [self.imageView, self.idTextField, self.passwordTextField, self.checkPasswordTextField, self.introductionTextView]
        
        return allComponent.reduce(true) {
            $0 && hasValue($1)
        }
    }
    
    func verifyPasswordEquality() -> Bool {
        guard let firstPassword = passwordTextField.text, let secondPassword = checkPasswordTextField.text else {
            return false
        }
        
        return firstPassword == secondPassword
    }
    
    func verifyToggleNextButton() {
        if verifyAllComponentHasValue() && verifyPasswordEquality() {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }

    @IBAction func pressedImageView(_ sender: UITapGestureRecognizer) {
        present(imagePicker, animated: true)
    }
    
    @IBAction func pressedBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func pressedNextButton(_ sender: UIButton) {
        guard let id = idTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let image = imageView.image else { return }
        guard let introduction = introductionTextView.text else { return }
        
        let userInformation = UserInformation.common
        userInformation.setId(id)
        userInformation.setPassword(password)
        userInformation.setImage(image)
        userInformation.setIntroduction(introduction)
    }
}

extension SignUpStep1ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true) {
            self.verifyToggleNextButton()
        }
    }
}

extension SignUpStep1ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        verifyToggleNextButton()
    }
}
