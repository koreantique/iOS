//
//  UserJoinViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/07/28.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class UserJoinViewController: UIViewController {

    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwConfirmTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //Check the fields and validate that the data is correct. If everything is correct, this method returns nil, Otherwise, it returns the error message
    func validateFields() -> String? {
        //Check that all fields are filled in
        if idTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || pwTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
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
        //validate the fields
        let error = validateFields()
        if error != nil {
            //There's something wrong with the fields, show error message
            print("error!!!!!")
        }else {
            //Create cleaned versions of the data
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = pwTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let id = idTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //Check for errors
                if err != nil{
                    //There was an error
                    print("Error creating user")
                }else {
                    //User was created successfully, now store the firse name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["name":name, "uid": result!.user.uid ]) { (error) in
                        if error != nil {
                            print("Error saving user data")
                        }
                    }
                    //transition to the home screen
                    self.transitionToHome()
                    
                }
            }
            
        }
        
    }
    
    func transitionToHome(){
        self.navigationController?.popToRootViewController(animated: true)
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
