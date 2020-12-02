import UIKit
import MobileCoreServices

class SignUpStep1ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkPasswordTextField.delegate = self
    }
    
    func hasValue(_ any: Any?) -> Bool {
        switch any {
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
        let allComponent = [self.imageView, self.idTextField, self.passwordTextField, self.checkPasswordTextField, self.textView]
        
        return allComponent.reduce(true) { result, next -> Bool in
            result && hasValue(next)
        }
    }
    
    func verifyPasswordEquality() -> Bool {
        guard let firstPassword = passwordTextField.text, let secondPassword = checkPasswordTextField.text else {
            return false
        }
        
        return firstPassword == secondPassword
    }

    @IBAction func pressedImageView(_ sender: UITapGestureRecognizer) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
    
    @IBAction func pressedBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension SignUpStep1ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true)
    }
}

extension SignUpStep1ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
}
