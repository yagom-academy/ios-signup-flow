import UIKit

class FirstSignUpPageController: UIViewController {
    
    let userInformation = UserInformation.default
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userIntroductionTextView: UITextView!
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var nextPageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        userIdTextField.delegate = self
        userPasswordTextField.delegate = self
        checkPasswordTextField.delegate = self
        
        nextPageButton.isEnabled = true
    }
    
    @IBAction func selectImageButton(_ sender: UIButton) {
        openPhotoAlbum()
    }
    
    @IBAction func moveToNextButton(_ sender: UIButton) {
        inputUserInformation()
        
        if let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondSignUpPageController") {
            self.navigationController?.pushViewController(pushVC, animated: true)
        } else {
            showAlert(title: "error!", message: "다음으로 이동할 수 없습니다.")
            return
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        resetUserInformation()
        dismiss(animated: true, completion: nil)
    }
}

// 사진앨범 접근
extension FirstSignUpPageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openPhotoAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(imagePicker.sourceType) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        } else {
            showAlert(title: "error!", message: "접근할 수 없습니다.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userImageView.image = pickedImage
        } else if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}

//error
extension FirstSignUpPageController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// 화면 터치시 키보드 내리기
extension FirstSignUpPageController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

// 유저가 입력한 데이터 관리
extension FirstSignUpPageController: UserInformationManageable {
    func inputUserInformation() {
        userInformation.id = userIdTextField.text
        userInformation.password = userPasswordTextField.text
        userInformation.profileImage = userImageView.image
        userInformation.selfIntroductionText = userIntroductionTextView.text
    }
    
    func resetUserInformation() {
        userInformation.id = nil
        userInformation.password = nil
        userInformation.profileImage = nil
        userInformation.selfIntroductionText = nil
        userInformation.phoneNumber = nil
        userInformation.birth = nil
    }
    
    func isAllRequirementFilled() -> Bool {
        let isPasswordSame: Bool = (userPasswordTextField.text == checkPasswordTextField.text)
        
        return userIdTextField.text != nil &&
               userPasswordTextField.text != nil &&
               userImageView.image != nil &&
               userIntroductionTextView.text != nil &&
               isPasswordSame
    }
}
