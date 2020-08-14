//
//  PostingViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/08/14.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit

class PostingViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = "Green DR 글쓰기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.red]
    }


}
