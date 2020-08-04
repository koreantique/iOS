//
//  SignViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/07/27.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit


class SignViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
    }
    
    @IBAction func tapUserJoinButton(_ sender: Any) {
        guard let UserVC = self.storyboard?.instantiateViewController(withIdentifier: "UserJoinPage") else {return}
        self.navigationController?.pushViewController(UserVC, animated: true)
    }
    
    
    @IBAction func tapCompanyJoinButton(_ sender: Any) {
        guard let CompanyVC = self.storyboard?.instantiateViewController(withIdentifier: "CompanyJoinPage") else {return}
        self.navigationController?.pushViewController(CompanyVC, animated: true)
    }

    @IBAction func tapLoginButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
