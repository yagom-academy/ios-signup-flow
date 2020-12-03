import UIKit

class SignUpPageController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    @IBAction func selectImageButton(_ sender: UIButton) {
        openPhotoAlbum()
    }
}

// 사진앨범 접근
extension SignUpPageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openPhotoAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(imagePicker.sourceType) {
            imagePicker.sourceType = .photoLibrary
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            showErrorAlert()
        }
    }
}

//error
extension SignUpPageController {
    func showErrorAlert() {
        let alert = UIAlertController(title: nil, message: "접근할 수 없습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension SignUpPageController: UITextFieldDelegate {
    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
}
