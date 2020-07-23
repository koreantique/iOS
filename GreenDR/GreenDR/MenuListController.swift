import UIKit

class MenuListController: UITableViewController{
    var items = ["그린DR이란?", "뉴스", "고객알림", "홍보게시판"]
    
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Self로 참조하는 부분에서 문제가 발생한다. 이렇게 해야 원하는 스토리보드를 지정하여 이동할 수 있다..
        //do something
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let GoNews = storyboard.instantiateViewController(withIdentifier: "NewsPage") //뉴스 게시판
        let GoNotice = storyboard.instantiateViewController(withIdentifier: "NoticePage") //고객 공지 페이지
        let GoPromotion = storyboard.instantiateViewController(withIdentifier: "PromotionPage") //고객 홍보 게시판
        
        switch indexPath.row {
        case 0: dismiss(animated: true)
        case 1: self.navigationController?.pushViewController(GoNews, animated: true)
        case 2: self.navigationController?.pushViewController(GoNotice, animated: true)
        case 3: self.navigationController?.pushViewController(GoPromotion, animated: true)
        default:
            return
        }

    }
}
