import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var companyButton: UIButton!
    
    //메인 타이틀 수정
    func changeTitle() {
        let fontSize = UIFont.boldSystemFont(ofSize: 25)
        let attributedStr = NSMutableAttributedString(string: titleLabel.text!)
        
        attributedStr.addAttribute(.foregroundColor, value: UIColor.darkGray, range: (titleLabel.text! as NSString).range(of: "로그인을"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: (titleLabel.text! as NSString).range(of: "뚝딱"))
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (titleLabel.text! as NSString).range(of: "뚝딱"))
        
        titleLabel.attributedText = attributedStr
    }
    
    //고객 선택 버튼 레이어 수정
    func changeButton() {
        userButton.layer.borderColor = UIColor.systemGray6.cgColor
        companyButton.layer.borderColor = UIColor.systemGray6.cgColor
        
        userButton.layer.borderWidth = 1
        companyButton.layer.borderWidth = 1
        
        userButton.layer.cornerRadius = 2
        companyButton.layer.cornerRadius = 2
    }
    
    func pickButton() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeTitle()
        changeButton()
        
    }
    
    @IBAction func tabUserButton(_ sender: Any) {
        
    }
    @IBAction func tapCompanyButton(_ sender: Any) {
        
    }
    
}
