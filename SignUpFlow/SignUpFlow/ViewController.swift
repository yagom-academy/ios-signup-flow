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

// 키보드 제어
extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
}

/*
1. 뷰에 아이템 다 올리기
2. 키보드
 키보드 커스터마이징
 엔터 눌렀을 때 키보드 내리기
3. 화면 이동 구현 / 다음 화면 뷰 생성
    * 모달? 네비게이션?
    네이게이션, 절차를 밟은 거니까?
*/
