//
//  PostingViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/08/14.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostingViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    let ad = UIApplication.shared.delegate as? AppDelegate
    let ref = Database.database().reference()
    var tomorrow: String = ""

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var contentsTextField: UITextView!
    
    
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
    

    
    func todayDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        tomorrow = formatter.string(from: Date())
        
//        tomorrowLabel.text = "\(tomorrow) 전력 생산 예측"
    }

    


    var selectedPriority: String?
    
    lazy var priorityTypes = ["\(tomorrow) 00:00", "\(tomorrow) 01:00", "\(tomorrow) 02:00", "\(tomorrow) 03:00", "\(tomorrow) 04:00", "\(tomorrow) 05:00", "\(tomorrow) 06:00", "\(tomorrow) 07:00", "\(tomorrow) 08:00", "\(tomorrow) 09:00", "\(tomorrow) 10:00", "\(tomorrow) 11:00", "\(tomorrow) 12:00", "\(tomorrow) 13:00", "\(tomorrow) 14:00", "\(tomorrow) 15:00", "\(tomorrow) 16:00", "\(tomorrow) 17:00", "\(tomorrow) 18:00", "\(tomorrow) 19:00", "\(tomorrow) 20:00", "\(tomorrow) 21:00", "\(tomorrow) 22:00", "\(tomorrow) 23:00"]
    
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
        
        createPickerView()
        dismissPickerView()
        todayDate()
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.red]

        self.contentsTextField.layer.borderWidth = 0.5
        self.contentsTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.contentsTextField.layer.cornerRadius = 5
        
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: {action in
            print("tapped Dismiss")
        }))
        
        present(alert, animated: true)
    }
    
    @IBAction func tapPostButton(_ sender: Any) {
        
        if(titleTextField.text == "" || timeTextField.text == "" || amountTextField.text == ""){
            self.showAlert(title: "알림", message: "항목을 모두 채워주세요.")
        }else{
            ref.child("Notice").childByAutoId().setValue(["title": titleTextField.text, "time": timeTextField.text, "amount": amountTextField.text, "contents": contentsTextField.text])
        
        self.showAlert(title: "알림", message: "공지가 등록되었습니다.")
            }
    }
        

}
