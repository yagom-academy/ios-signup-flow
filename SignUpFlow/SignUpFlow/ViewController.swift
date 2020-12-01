import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appLogoImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func touchUpSignUpButton(_ sender: UIButton) {
    }
}


//1. 뷰에 아이템 다 올리기
//2. 키보드
//3. 화면 이동 구현 / 다음 화면 뷰 생성
//    * 모달? 네비게이션?
//                    네이게이션, 절차를 밟은 거니까?
