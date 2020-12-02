import UIKit
import MobileCoreServices

class SignUpStep1ViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension SignUpStep1ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true)
    }
}
