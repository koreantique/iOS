//
//  PredictViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/07/29.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit

class PredictViewController: UIViewController {

    @IBOutlet weak var ButtonS1: UIButton!
    @IBOutlet weak var ButtonS2: UIButton!
    
    @IBOutlet weak var ButtonH1: UIButton!
    @IBOutlet weak var ButtonH2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = "풍력발전 예측정보"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        
        ButtonS1.layer.cornerRadius = 0.5 * ButtonS1.bounds.size.width
        ButtonS2.layer.cornerRadius = 0.5 * ButtonS2.bounds.size.width
        ButtonH1.layer.cornerRadius = 0.5 * ButtonH1.bounds.size.width
        ButtonH2.layer.cornerRadius = 0.5 * ButtonH2.bounds.size.width
    }
    

    @IBAction func tapS1Button(_ sender: Any) {
        self.performSegue(withIdentifier: "PredictDetailSegue", sender: self)
    }
    @IBAction func tapS2Button(_ sender: Any) {
        self.performSegue(withIdentifier: "PredictDetailSegue", sender: self)
    }
    @IBAction func tapH1Button(_ sender: Any) {
        self.performSegue(withIdentifier: "PredictDetailSegue", sender: self)
    }
    @IBAction func tapH2Button(_ sender: Any) {
        self.performSegue(withIdentifier: "PredictDetailSegue", sender: self)
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
