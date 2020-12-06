import UIKit

class SignUpStep1ViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    private let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introductionTextView.delegate = self
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// 입력된 UIView의 value가 들어있는지 Bool 값으로 반환하는 함수.
    ///
    /// - Parameter uiView: value의 유무를 확인할 UIView
    /// - Returns: value가 있으면, true 없으면 false
    func isViewHasValue(_ checkingView: UIView?) -> Bool {
        switch checkingView {
        case let imageView as UIImageView:
            return imageView.image != nil
        case let textField as UITextField:
            return textField.hasText
        case let textView as UITextView:
            return textView.hasText
        default:
            return false
        }
    }
    
    /// Signup Step1의 모든 뷰 컴포넘트에 값이 있는지 확인 후  Bool로 결과를 반환하는 함수.
    ///
    /// - Returns: value가 모두 있으면 true, 없으면 false
    func verifyAllComponentHasValue() -> Bool {
        let allComponent = [self.profileImageView, self.idTextField, self.passwordTextField, self.checkPasswordTextField, self.introductionTextView]
        
        return allComponent.reduce(true) {
            $0 && isViewHasValue($1)
        }
    }
    
    /// password와 check password의 일치 여부를 반환하는 함수.
    ///
    /// - Returns: 일차하면 true, 아니면 false
    func verifyPasswordEquality() -> Bool {
        guard let firstPassword = passwordTextField.text, let secondPassword = checkPasswordTextField.text else {
            return false
        }
        
        return firstPassword == secondPassword
    }
    
    /// Signup Step1이 정상적으로 입력 완료되면 다음 버튼을 활성화 하는 함수.
    func checkNextButtonActivation() {
        if verifyAllComponentHasValue() && verifyPasswordEquality() {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func didChangedIDTextField(_ sender: UITextField) {
        checkNextButtonActivation()
    }
    
    @IBAction func didChangedPasswordTextField(_ sender: UITextField) {
        checkNextButtonActivation()
    }
    
    @IBAction func didChangedCheckPasswordTextField(_ sender: UITextField) {
        checkNextButtonActivation()
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
        guard let image = profileImageView.image else { return }
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
        profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true) {
            self.checkNextButtonActivation()
        }
    }
}

extension SignUpStep1ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkNextButtonActivation()
    }
}
