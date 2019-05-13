//
//  SeeADocTableViewCell.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class SeeADocTableViewCell: UITableViewCell {

    @IBOutlet weak var waitTimeLbl: UILabel!
    @IBOutlet weak var certifyLbl: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var vu: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
