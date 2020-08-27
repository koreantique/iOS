import UIKit

class JoinViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.changeTitle(label: titleLabel)
    }
}
