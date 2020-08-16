//
//  BiddingDataViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/08/17.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit

class BiddingDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "biddingCell", for: indexPath) as! DataType
        

        
        let data: DataModel
        
        data = dataList[indexPath.row]
        
        cell.timeLabel.text = data.time
        cell.amountLabel.text = data.amount
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    @IBOutlet weak var tableViewMain: UITableView!
    
    var dataList = [DataModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        // Do any additional setup after loading the view.
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        //tableViewMain.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        //sample data 삽입
        let sample = DataModel(time: "2020-08-18 13:00", amount: "252(KW)")
        dataList.append(sample)
        
        
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
