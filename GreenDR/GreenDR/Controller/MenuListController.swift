import UIKit

class MenuListController: UITableViewController{
    var items = ["그린DR이란?", "알림게시판", "예측정보", "뉴스"]
    
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    let whiteColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
    let lightGreenColor = UIColor(red: 232/255.0, green: 253/255.0, blue: 202/255.0, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = whiteColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .darkGray
        cell.backgroundColor = lightGreenColor
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Self로 참조하는 부분에서 문제가 발생한다. 이렇게 해야 원하는 스토리보드를 지정하여 이동할 수 있다..
        //do something
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        //AppDelegate 데이터 참조
        let ad = UIApplication.shared.delegate as? AppDelegate

        let GoNotice = storyboard.instantiateViewController(withIdentifier: "NoticePage") //고객 공지 페이지
        let GoPredict = storyboard.instantiateViewController(withIdentifier: "PredictPage") //예측데이터 게시판
        let GoNews = storyboard.instantiateViewController(withIdentifier: "NewsPage") //뉴스 게시판
        
        switch indexPath.row {
        case 0: dismiss(animated: true)
        case 1: if(ad?.paramID != nil){
            self.navigationController?.pushViewController(GoNotice, animated: true)} else{showAlert(title: "알림", message: "로그인을 먼저 해주세요")}
        case 2: self.navigationController?.pushViewController(GoPredict, animated: true)
        case 3: self.navigationController?.pushViewController(GoNews, animated: true)
        default:
            return
        }

    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: {action in
            print("tapped Dismiss")
        }))
        
        present(alert, animated: true)
    }
}
