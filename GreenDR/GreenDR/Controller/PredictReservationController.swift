//
//  PredictReservationController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/08/16.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PredictReservationController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource {


    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var predictLabel: UILabel!
    @IBOutlet weak var canUseLabel: UILabel!
    
    var paramElec: String = ""
    var tomorrow: String = ""
    
    let ref = Database.database().reference()
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorityTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorityTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = priorityTypes[row]
        timeTextField.text = selectedPriority
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: {action in
            print("tapped Dismiss")
        }))
        
        present(alert, animated: true)
    }
    
    func todayDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        tomorrow = formatter.string(from: Date()+86400)
        
        print("\(tomorrow) 전력 생산 예측")
    }

        


    var selectedPriority: String?
    
    lazy var priorityTypes = ["\(tomorrow) 14:00", "\(tomorrow) 15:00", "\(tomorrow) 16:00", "\(tomorrow) 17:00", "\(tomorrow) 18:00", "\(tomorrow) 19:00", "\(tomorrow) 20:00", "\(tomorrow) 21:00"]
    
    func createPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        timeTextField.inputView = pickerView
    }
    
    func dismissPickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        timeTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createPickerView()
        dismissPickerView()
        todayDate()
        
        self.predictLabel.text = paramElec
        self.canUseLabel.text = "253(KW)"
        
    }
    
    
    
    @IBAction func tapReservationButton(_ sender: Any) {
        if(textField.text == ""){
            self.showAlert(title: "알림", message: "예약하실 추가 전력 사용량을 입력하세요.")
        }else{
            ref.child("Reservation").childByAutoId().setValue(["amount": textField.text!, "time": timeTextField.text!, "type": "0"])
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
