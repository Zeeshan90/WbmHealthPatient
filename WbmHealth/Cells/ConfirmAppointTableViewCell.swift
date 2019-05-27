//
//  ConfirmAppointTableViewCell.swift
//  WbmHealth
//
//  Created by WBM on 5/27/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class ConfirmAppointTableViewCell: UITableViewCell {

    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var Vu: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
