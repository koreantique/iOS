import UIKit

//메인 타이틀 수정
class Helper{
    static func changeTitle(label: UILabel) {
        let fontSize = UIFont.boldSystemFont(ofSize: 25)
        let attributedStr = NSMutableAttributedString(string: label.text!)
        
        attributedStr.addAttribute(.foregroundColor, value: UIColor.darkGray, range: (label.text! as NSString).range(of: "로그인을"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: (label.text! as NSString).range(of: "뚝딱"))
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (label.text! as NSString).range(of: "뚝딱"))
        
        label.attributedText = attributedStr
    }
}
