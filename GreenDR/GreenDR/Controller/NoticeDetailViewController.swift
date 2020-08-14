//
//  NoticeDetailViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/08/14.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit

class NoticeDetailViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var paramTime: String = ""
    var paramAmount: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        // Do any additional setup after loading the view.
        
        self.timeLabel.text = paramTime
        self.amountLabel.text = paramAmount
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
