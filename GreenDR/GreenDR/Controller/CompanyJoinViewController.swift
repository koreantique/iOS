//
//  CompanyJoinViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/07/28.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import Firebase

class CompanyJoinViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwConfirmTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyNumTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
    }
    
    func validateFields() -> String? {
        //Check that all fields are filled in
        if pwTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        
        //Check if the password is secure
        let cleanedPassword = pwTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordTest(cleanedPassword) == false{
            return "Please make sure your password is at leaset 8 characters, contains a special character and a number"
        }
        
        return nil
    }
    
    @IBAction func tapSignUp(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            print("error!!")
        }else {
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = pwTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            let usertype = 0
            
            Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
                if err != nil{
                    print("Error creating user")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name":name, "password":password, "phone":phone, "uid":res!.user.uid, "usertype": usertype]) { (err) in
                        if err != nil {
                            print("Error saving user data")
                        }
                    }
                    self.transitionToHome()
                }
            }
        }
    }
    func transitionToHome(){
        self.navigationController?.popToRootViewController(animated: true)
    }
}
