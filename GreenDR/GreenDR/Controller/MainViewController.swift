import SideMenu
import UIKit

class MainViewController: UIViewController{
    var menu: SideMenuNavigationController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //햄버거 메뉴 생성
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 230.0/255.0, green: 234.0/255.0, blue: 230.0/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "GreenDR")
        imageView.image = image
        navigationItem.titleView = imageView
    }

    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        present(menu!, animated: true)
    }
    
    
    
    
    //perINFO버튼을 클릭했을 때 로그인이 되어있으면 개인정보 화면, 로그인이 되어있지 않으면 로그인 화면을 띄워야 한다.
    @IBAction func didTapPerINFO(_ sender: UIBarButtonItem) {
        //AppDelegate 데이터 참조
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        //이동할 뷰 컨트롤러 객체를 ID를 통해 참조
        let LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! LoginViewController
        LoginVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        //delegate설정
        LoginVC.selectionDelegate = self


        let PerInfoVC = self.storyboard!.instantiateViewController(withIdentifier: "PersonalInfoPage")
        PerInfoVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        if (ad?.paramID == nil){
            self.present(LoginVC, animated: true)
        } else{
            self.navigationController?.pushViewController(PerInfoVC, animated: true)
        }
    }
}

//dismiss 후 다음페이지 넘기기 위한 delegate
extension MainViewController: SignButtonDelegate{
    func didTapButton() {
        guard let SignVC = self.storyboard?.instantiateViewController(withIdentifier: "SignPage") else {print("error"); return}
        self.navigationController?.pushViewController(SignVC, animated: true)
    }
}
