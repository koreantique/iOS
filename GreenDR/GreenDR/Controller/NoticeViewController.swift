//
//  NoticeViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/07/21.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    
    @IBOutlet var tableViewMain: UITableView!

    var noticeList = [NoticeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = "알림 게시판"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        // Do any additional setup after loading the view.
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        tableViewMain.separatorStyle = UITableViewCell.SeparatorStyle.none

        
        ref = Database.database().reference().child("Notice")
        ref.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                self.noticeList.removeAll()
                
                for notices in snapshot.children.allObjects as![DataSnapshot]{
                    let noticeObject = notices.value as? [String: AnyObject]
                    let noticeTitle = noticeObject?["title"]
                    let noticeTime = noticeObject?["time"]
                    let noticeAmount = noticeObject?["amount"]
                    
                    let notice = NoticeModel(title: noticeTitle as! String?, time: noticeTime as! String?, amount: noticeAmount as! String?)
                    
                    self.noticeList.append(notice)
                }
                self.tableViewMain.reloadData()
            }
        }
    }

    @IBAction func tapPostButton(_ sender: Any) {
        self.performSegue(withIdentifier: "PostingSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "NoticeDetailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoticeType
        
        let notice: NoticeModel
        
        notice = noticeList[indexPath.row]
        
        cell.titleLabel.text = notice.title
        cell.timeLabel.text = notice.time! + "시"
        cell.amountLabel.text = notice.amount! + "KW"
        
        return cell
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        
        guard let rvc = dest as? NoticeDetailViewController else{
            return
        }
        
        rvc.paramAmount = "156KW"
        rvc.paramTime = "13:00"
        
    }
}
