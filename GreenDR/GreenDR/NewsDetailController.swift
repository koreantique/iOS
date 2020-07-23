import UIKit

class NewsDetailController: UIViewController{
    
    @IBOutlet weak var ImageMain: UIImageView!
    @IBOutlet weak var LabelMain: UILabel!
    
    //1. image url
    //2. description
    
    var imageUrl: String?
    var desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ok?!
        if let img = imageUrl{
            //이미지 가져와서 뿌린다.
            if let data = try? Data(contentsOf: URL(string: img)!){
                //MainThred
                DispatchQueue.main.async {
                    self.ImageMain.image = UIImage(data: data)
                }
            }
            
            
        }
        
        if let d = desc{
            self.LabelMain.text = d
        }
    }
}
