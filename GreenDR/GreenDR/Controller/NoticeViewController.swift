//
//  NoticeViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/07/21.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {
    

    @IBOutlet var tableViewMain: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = "알림 게시판"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        // Do any additional setup after loading the view.
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        
    }

    @IBAction func tapPostButton(_ sender: Any) {
        self.performSegue(withIdentifier: "PostingSegue", sender: self)
    }
    
}

extension NoticeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}

extension NoticeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Hello World!"
        return cell
    }
}
