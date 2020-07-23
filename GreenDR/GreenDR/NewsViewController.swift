import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    var newsData: Array<Dictionary<String, Any>>?
    //1. http통신 방법 - urlsession
    //2. JSON 데이터 형태 {"돈(key)":"10000(value)"} {["100","1000","꽝"]}
    //3. 테이블뷰의 데이터 매칭 후 통보해야 한다. 그 후에 화면 그리기!
    //!!!! network : background / ui : Main
    
    //500회 무료
    func getNews() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&category=technology&apiKey=8d6464cd25cf46ffb4776eaf56008f70")!) { (data, response, error) in
            
            if let dataJson = data{
                
                //json parsing
                do{
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any> //Dictonary로 강제변환. <String(key), Any(value)>
                    print(json)
                    //Dictionary
                    let articles = json["articles"] as! Array<Dictionary<String, Any>> //json에서 articles를 Array<Dictionary<String, Any>> 형태로 가져오는법.
                    print(articles)
                    self.newsData = articles
                    
                    //화면은 Background가 아닌 main에서 그려아 한다.
                    DispatchQueue.main.async {
                        self.TableViewMain.reloadData()
                    }
                }
                catch{}
                
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //몇개? 숫자
        
        if let news = newsData{
            return news.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //무엇?
        
        //as : 부모 자식 친자확인.
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        
        let idx = indexPath.row
        if let news = newsData{
            let row = news[idx]
            if let r = row as? Dictionary<String, Any> {
                if let title = r["title"] as? String{
                    cell.LabelText.text = title
                }
            }
        }
        
        return cell
    }
    
    //1. 옵션 - 클릭 감지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK!!! \(indexPath.row)")
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "NewsDetailPage") as! NewsDetailController
        
        if let news = newsData{
            let row = news[indexPath.row]
            if let r = row as? Dictionary<String, Any> {
                if let image = r["urlToImage"] as? String{
                    controller.imageUrl = image
                }
                if let desc = r["description"] as? String{
                    controller.desc = desc
                }
                
            }
        }
        //이동! - 수동
        showDetailViewController(controller, sender: nil)
    }
    
    //2. 세그웨이 :
    //override : 부모/자식 개념. 부모의 함수를 가져다 쓰는 것이다. 여기서는 UIViewController에 있는 prepare함수를 쓴 것.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "NewsDetail" == id {
            if let controller = segue.destination as? NewsDetailController{
                if let news = newsData{
                    if let indexPath = TableViewMain.indexPathForSelectedRow{
                        let row = news[indexPath.row]
                        if let r = row as? Dictionary<String, Any> {
                            if let imageUrl = r["urlToImage"] as? String{
                                controller.imageUrl = imageUrl
                            }
                            if let desc = r["description"] as? String{
                                controller.desc = desc
                            }
                        }
                    }
                }
            }
        }
            //이동! - 자동
    }
    //1. 디테일(상세) 화면 만들기
    //2. 값을 보내기 (1.tableview delegate/ 2.storyboard (segue))
    //3. 화면 이동 (이동하기 전에 값을 미리 셋팅해야 한다!!!!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        
        getNews()
    }
    

}
