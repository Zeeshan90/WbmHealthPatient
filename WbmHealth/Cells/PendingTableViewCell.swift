//
//  PendingTableViewCell.swift
//  WbmHealth
//
//  Created by WBM on 5/27/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class PendingTableViewCell: UITableViewCell {

    @IBOutlet weak var chargesLbl: UILabel!
    @IBOutlet weak var doctorNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var TimeLbl: UILabel!
    @IBOutlet weak var vu: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
