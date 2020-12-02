import UIKit

final class FirstSignUpViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var checkPasswordField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView(gestureRecognizer:)))
        
        self.view.addGestureRecognizer(tapRecognizer)
    }
        
    @objc func tapView(gestureRecognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func editProfileImage(_ sender: UITapGestureRecognizer) {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        
        self.present(self.imagePicker, animated: true)
    }
    
    @IBAction func popToPreviousView() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FirstSignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var resultImage: UIImage? = nil
        
        if let editedImage = info[.editedImage] as? UIImage {
            resultImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            resultImage = originalImage
        }
        
        profileImage.image = resultImage
        
        picker.dismiss(animated: true)
    }
}
