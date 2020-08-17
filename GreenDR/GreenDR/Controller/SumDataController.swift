//
//  SumDataController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/08/17.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit

class SumDataController: UIViewController {

    @IBOutlet weak var countingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        // Do any additional setup after loading the view.
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    var startValue = 0
    let endValue = 183
    
    @objc func handleUpdate() {
        self.countingLabel.text = "\(startValue)"
        startValue += 1

        if startValue > endValue {
            startValue = endValue
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
