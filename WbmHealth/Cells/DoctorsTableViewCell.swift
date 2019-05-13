//
//  DoctorsTableViewCell.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class DoctorsTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var speciality: UILabel!
    @IBOutlet weak var expLbl: UILabel!
    @IBOutlet weak var qualifLbl: UILabel!
    @IBOutlet weak var feeLbl: UILabel!
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
