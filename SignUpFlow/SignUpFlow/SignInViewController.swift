import UIKit

final class SignInViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView(gestureRecognizer:)))
        
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tapView(gestureRecognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
}

