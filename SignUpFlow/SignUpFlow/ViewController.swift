import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextFieldConfig(idTextField)
        passwordTextFieldConfig(passwordTextField)
    }

    //MARK: - IBActions
    @IBAction func didTapSignInButton(_ sender: UIButton) {
    }
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
    }
    
    //MARK: - TextField Configuration
    private func idTextFieldConfig(_ textField: UITextField) {
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
    }
    private func passwordTextFieldConfig(_ textField: UITextField) {
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
    }
}

