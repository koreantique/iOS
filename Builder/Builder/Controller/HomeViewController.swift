//
//  HomeController.swift
//  Builder
//
//  Created by 박용범 on 2020/08/25.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import DropDown

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
      
    @IBOutlet weak var selectLocationButton: UIBarButtonItem!
    @IBOutlet weak var JobTable: UITableView!

    

    //menu 데이터 넣기
    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "충장로 4가",
            "내 동네 설정하기"
        ]
        return menu
    }()
    
    //table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let customCell = tableView.dequeueReusableCell(withIdentifier: JobTableViewCell.identifier, for: indexPath) as! JobTableViewCell
//            customCell.configure(with: "launch")
        return customCell
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu.anchorView = selectLocationButton
        //dropdown이 메뉴를 가리지 않게 설정하기
        menu.bottomOffset = CGPoint(x: 0, y:(menu.anchorView?.plainView.bounds.height)!)

        //menu 선택 지역으로 이동하기. 동적으로 수정해야함.
        menu.selectionAction = { index, title in
            if(index == 1){
                print("지역 선택으로 이동")
            }
        }
        
        menu.textFont.withSize(12)
        
        //navigation bar bottom line 없애기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //navigation bar item 색상
        self.navigationController?.navigationBar.tintColor = .darkGray
        
        //table View
        JobTable.register(JobTableViewCell.nib(), forCellReuseIdentifier: JobTableViewCell.identifier)
        JobTable.delegate = self
        JobTable.dataSource = self
        
    }
    
    //화면 touch 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tabSelectLocationButton(_ sender: Any) {
        menu.show()
    }
    

}
