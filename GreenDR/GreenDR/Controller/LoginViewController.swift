import UIKit

protocol SignButtonDelegate {
    func didTapButton()
}
class LoginViewController: UIViewController{
    
    var selectionDelegate: SignButtonDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapSignButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        selectionDelegate.didTapButton()
    }
}
