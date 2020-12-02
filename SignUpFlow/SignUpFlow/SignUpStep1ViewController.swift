import UIKit
import MobileCoreServices

class SignUpStep1ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func pressedImageView(_ sender: UITapGestureRecognizer) {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
        present(imagePicker, animated: true)
    }
}
