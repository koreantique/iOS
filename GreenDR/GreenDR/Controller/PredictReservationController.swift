//
//  PredictReservationController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/08/16.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PredictReservationController: UIViewController {


    @IBOutlet weak var tomorrow: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var predictLabel: UILabel!
    @IBOutlet weak var canUseLabel: UILabel!
    
    var paramElec: String = ""
    
    let ref = Database.database().reference()
    
    func todayDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date_string = formatter.string(from: Date()+86400)
        
        tomorrow.text = "\(current_date_string) (내일)"
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: {action in
            print("tapped Dismiss")
        }))
        
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        todayDate()
        
        self.predictLabel.text = paramElec
        self.canUseLabel.text = "46(KW)"
        
    }
    
    @IBAction func tapReservationButton(_ sender: Any) {
        if(textField.text == ""){
            self.showAlert(title: "알림", message: "예약하실 추가 전력 사용량을 입력하세요.")
        }else{
            ref.child("EconomicReservation").childByAutoId().setValue(["amount": textField.text])
            self.showAlert(title: "알림", message: "예약 신청이 완료되었습니다.")
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
