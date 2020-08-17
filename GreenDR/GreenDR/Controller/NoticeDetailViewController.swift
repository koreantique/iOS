//
//  NoticeDetailViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/08/14.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NoticeDetailViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var contentsTextField: UITextView!

    let ref = Database.database().reference()
    
    var notice: NoticeModel?
    var amount: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        // Do any additional setup after loading the view.
        amount = Int(notice!.amount!)!
        
        
        self.timeLabel.text = notice?.time
        self.amountLabel.text = "\(amount/10) KW"
        self.contentsTextField.text = notice?.contents
        self.titleTextField.text = notice?.title
        self.titleTextField.layer.borderColor = UIColor.black.cgColor
        self.titleTextField.layer.borderWidth = 0.5
        self.contentsTextField.layer.borderColor = UIColor.black.cgColor
        self.contentsTextField.layer.borderWidth = 0.5
        
        ref.child("Notice").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            print(value)
        }
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: {action in
            print("tapped Dismiss")
        }))
        
        present(alert, animated: true)
    }
    @IBAction func tapButton(_ sender: Any) {
        if(textField.text == ""){
            self.showAlert(title: "알림", message: "추가 신청 전령략을 입력하세요.")
        }else{
            ref.child("Reservation").childByAutoId().setValue(["amount": textField.text!, "time": timeLabel.text!, "type": "1"])
            self.showAlert(title: "알림", message: "신청이 완료되었습니다.")
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
