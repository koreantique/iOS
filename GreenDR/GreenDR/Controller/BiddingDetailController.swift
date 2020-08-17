//
//  BiddingDetailController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/08/17.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BiddingDetailController: UIViewController {
    
    var data: DataModel?
    let ref = Database.database().reference().child("Reservation")
    
    @IBOutlet weak var timeTextView: UILabel!
    @IBOutlet weak var amountTextView: UILabel!
    @IBOutlet weak var typeTextView: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeTextView.text = data?.time
        amountTextView.text = data?.amount
        typeTextView.text = data?.type
        // Do any additional setup after loading the view.
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: {action in
            print("tapped Dismiss")
        }))
        
        present(alert, animated: true)
    }
    
    @IBAction func tapCancleButton(_ sender: Any) {
        self.showAlert(title: "알림", message: "입찰이 취소되었습니다.")
    
        ref.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                for datas in snapshot.children.allObjects as![DataSnapshot]{
                    let dataObject = datas.value as? [String: AnyObject]
                    
                    let dataTime = dataObject?["time"]
                    
                    if(dataTime as! String? == self.timeTextView.text){
                        print(datas.key)
                        self.ref.child("\(datas.key)").removeValue()
                        
                    }
                }
            }
        }
        
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
