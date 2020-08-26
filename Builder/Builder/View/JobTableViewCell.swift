//
//  JobTableViewCell.swift
//  Builder
//
//  Created by 박용범 on 2020/08/26.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    static let identifier = "JobTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "JobTableViewCell", bundle: nil)
    }
    
    //table view controller에서 뭐 보여줄지.
//    public func configure(with imageName: String){
//        myImageView.image = UIImage(systemName: imageName)
//    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
