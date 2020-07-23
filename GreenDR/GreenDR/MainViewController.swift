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
    }
    
    @IBAction func newsButton(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "NewsPage") else {return}
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        present(menu!, animated: true)
    }
    
    //perINFO버튼을 클릭했을 때 로그인이 되어있으면 개인정보 화면, 로그인이 되어있지 않으면 로그인 화면을 띄워야 한다.
    @IBAction func didTapPerINFO(_ sender: UIBarButtonItem) {
        //AppDelegate 데이터 참조
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        //이동할 뷰 컨트롤러 객체를 ID를 통해 참조
        let LoginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginPage")
        LoginVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        let PerInfoVC = self.storyboard!.instantiateViewController(withIdentifier: "PersonalInfoPage")
        PerInfoVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        if (ad?.paramID == nil){
            self.present(LoginVC, animated: true)
        } else{
            self.present(PerInfoVC, animated: true)
        }
    }
}
