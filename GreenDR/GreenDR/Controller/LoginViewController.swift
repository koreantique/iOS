import UIKit
import FirebaseAuth

protocol SignButtonDelegate {
    func didTapButton()
}

var perButtonFlag: Bool = false
var comButtonFlag: Bool = false
var pickUserFlag: Int = 0

class LoginViewController: UIViewController{
    
    let ad = UIApplication.shared.delegate as? AppDelegate
    
    var selectionDelegate: SignButtonDelegate!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var perButton: UIButton!
    @IBOutlet weak var comButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perButtonFlag = false
        comButtonFlag = false
    }
    
    //button picker
    @IBAction func tapPerButton(_ sender: Any) {
        if(perButtonFlag == false){
            perButton.layer.borderColor = UIColor.darkGray.cgColor
            perButton.layer.borderWidth = 1.5
            perButtonFlag = true
            
            if(comButtonFlag == true){
                comButton.layer.borderColor = nil
                comButton.layer.borderWidth = 0
                comButtonFlag = false
            }
            pickUserFlag = 1
        }
        
    }
    @IBAction func tapComButton(_ sender: Any) {
        if(comButtonFlag == false){
            comButton.layer.borderColor = UIColor.darkGray.cgColor
            comButton.layer.borderWidth = 1.5
            comButtonFlag = true
            
            if(perButtonFlag == true){
                perButton.layer.borderColor = nil
                perButton.layer.borderWidth = 0
                perButtonFlag = false
            }
            pickUserFlag = 0
        }
    }
    
    @IBAction func tapSignButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        selectionDelegate.didTapButton()
    }
    @IBAction func tapLoginButton(_ sender: Any) {
        //validate text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.showAlert(title: "알림", message: "아이디 또는 패스워드를 확인하세요.")
            }else {
                self.ad?.paramID = self.emailTextField.text
                self.ad?.paramSession = true
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: {action in
            print("tapped Dismiss")
        }))
        
        present(alert, animated: true)
    }
}
