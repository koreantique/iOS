//
//  BiddingDataViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/08/17.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BiddingDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let lightGreenColor = UIColor(red: 146/255.0, green: 214/255.0, blue: 49/255.0, alpha: 1)
    
    var ref: DatabaseReference!
    var dataList = [DataModel]()
    
    @IBOutlet weak var tableViewMain: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "BiddingSegue", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "biddingCell", for: indexPath) as! DataType
        

        
        let data: DataModel
        
        data = dataList[indexPath.row]
        
        cell.timeLabel.text = data.time
        cell.amountLabel.text = "\(String(describing: data.amount!)) KW"
        cell.typeLabel.text = data.type
        

        if(data.type == "(경제성)"){
            cell.typeLabel.textColor = lightGreenColor
        } else{
            cell.typeLabel.textColor = UIColor.red
        }
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            BiddingDetailController{
            destination.data = dataList[(tableViewMain.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        // Do any additional setup after loading the view.
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        tableViewMain.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        ref = Database.database().reference().child("Reservation")
        ref.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                
                self.dataList.removeAll()
                
                for datas in snapshot.children.allObjects as![DataSnapshot]{
                    let dataObject = datas.value as? [String: AnyObject]
                    
                    let dataAmount = dataObject?["amount"]
                    let dataTime = dataObject?["time"]
                    var dataType: String = ""
                    if(dataObject?["type"] as! String? == "1"){
                        dataType = "(신뢰성)"
                    }else {
                        dataType = "(경제성)"
                    }
                    
                    let data = DataModel(time: dataTime as! String?, amount: dataAmount as! String?, type: dataType as String?)
                    
                    self.dataList.append(data)
                }
                self.tableViewMain.reloadData()
            }
        }
        
        //sample data 삽입
//        let sample = DataModel(time: "2020-08-18 13:00", amount: "252(KW)")
//        dataList.append(sample)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
