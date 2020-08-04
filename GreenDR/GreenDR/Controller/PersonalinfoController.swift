import UIKit
import Firebase
class PersonalinfoController: UIViewController{
    
    @IBAction func tapSignoutButton(_ sender: Any) {
        let userInfo = Auth.auth()
        
        do{
            try userInfo.signOut()
            }catch let signOutError as NSError {
            print("error signing out \(signOutError)")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = "내정보"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
    }
    
}
