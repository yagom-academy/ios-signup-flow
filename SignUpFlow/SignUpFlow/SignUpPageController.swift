import UIKit

class SignUpPageController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    @IBAction func selectImageButton(_ sender: UIButton) {
    }
}

extension SignUpPageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}

extension SignUpPageController: UITextFieldDelegate {
    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
}
