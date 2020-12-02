import UIKit
import MobileCoreServices

class SignUpStep1ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func isEmpty(_ any: Any) -> Bool {
        switch any {
        case let imageView as UIImageView:
            if imageView.image != nil {
                return false
            }
        case let textField as UITextField:
            if textField.text != nil {
                return false
            }
        case let textView as UITextView:
            if textView.text != nil {
                return false
            }
        default:
            return true
        }
        
        return true
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
