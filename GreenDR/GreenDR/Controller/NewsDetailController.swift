import UIKit

class NewsDetailController: UIViewController{
    
    @IBOutlet weak var ImageMain: UIImageView!
    @IBOutlet weak var LabelMain: UILabel!
    @IBOutlet weak var TitleMain: UILabel!
    
    //1. image url
    //2. description
    
    var imageUrl: String?
    var desc: String?
    var tit: String?
    
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
        
        if let data = desc{
            self.LabelMain.text = data
        }
        
        if let title = tit{
            self.TitleMain.text = title
        }
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = "뉴스"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
    }
}
