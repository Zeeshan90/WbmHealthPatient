//
//  CarePlanTableViewCell.swift
//  WbmHealth
//
//  Created by WBM on 5/7/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class CarePlanTableViewCell: UITableViewCell {

    @IBOutlet weak var vu: UIView!
    @IBOutlet weak var frstLeftVu: UILabel!
    @IBOutlet weak var frstRightVu: UILabel!
    @IBOutlet weak var secondLeftVu: UILabel!
    @IBOutlet weak var secondRightVu: UILabel!
    @IBOutlet weak var thirdLeftVu: UILabel!
    @IBOutlet weak var thirdRightVu: UILabel!
    
    @IBOutlet weak var forthLeftVu: UILabel!
    @IBOutlet weak var forthRightVu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}

