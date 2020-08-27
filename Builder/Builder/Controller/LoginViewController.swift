import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var companyButton: UIButton!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    //고객 선택 버튼 레이어 수정
    func changeButton() {
        userButton.layer.borderColor = UIColor.systemGray3.cgColor
        companyButton.layer.borderColor = UIColor.systemGray3.cgColor
        
        userButton.layer.borderWidth = 1
        companyButton.layer.borderWidth = 1
        
        userButton.layer.cornerRadius = 2
        companyButton.layer.cornerRadius = 2
        
        //버튼 Label을 여러줄로 만드는 작업
        userButton.titleLabel?.lineBreakMode = .byWordWrapping
        userButton.titleLabel?.textAlignment = .center
//        userButton.setTitle("개인회원\n(일자리 찾기)", for: .normal)
        
        companyButton.titleLabel?.lineBreakMode = .byWordWrapping
        companyButton.titleLabel?.textAlignment = .center
//        companyButton.setTitle("기업회원\n(건설인력 찾기)", for: .normal)
        
        //버튼 Label 텍스트 설정
        let fontSize = UIFont.boldSystemFont(ofSize: 18)

        let userButtonText = NSMutableAttributedString(string: "개인회원\n(일자리 찾기)")
        let companyButtonText = NSMutableAttributedString(string: "기업회원\n(건설인력 찾기)")


        userButtonText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: ((userButton.titleLabel?.text!)! as NSString).range(of: "개인"))
        companyButtonText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: ((companyButton.titleLabel?.text!)! as NSString).range(of: "기업"))
        
    
        print(userButtonText)
        userButton.setAttributedTitle(userButtonText, for: .normal)
        companyButton.setAttributedTitle(companyButtonText, for: .normal)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.changeTitle(label: titleLabel)
        changeButton()
        
    }
    
    @IBAction func tabUserButton(_ sender: Any) {
        userButton.layer.borderColor = UIColor.systemYellow.cgColor
        userButton.layer.backgroundColor = UIColor.white.cgColor
        companyButton.layer.borderColor = UIColor.systemGray3.cgColor
        companyButton.layer.backgroundColor = UIColor.systemGray6.cgColor
    }
    @IBAction func tapCompanyButton(_ sender: Any) {
        companyButton.layer.borderColor = UIColor.systemYellow.cgColor
        companyButton.layer.backgroundColor = UIColor.white.cgColor
        userButton.layer.borderColor = UIColor.systemGray3.cgColor
        userButton.layer.backgroundColor = UIColor.systemGray6.cgColor
    }
    @IBAction func tabLoginButton(_ sender: Any) {
        
    }
    @IBAction func tabJoinButton(_ sender: Any) {
    }
    @IBAction func tapKakaoButton(_ sender: Any) {
    }
    @IBAction func tabAppleButton(_ sender: Any) {
    }
    @IBAction func tabFindIdButton(_ sender: Any) {
    }
    @IBAction func tabFindPwButton(_ sender: Any) {
    }
    
    
}
