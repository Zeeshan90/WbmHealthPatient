//
//  ExperianceTableViewCell.swift
//  WbmHealth
//
//  Created by WBM on 5/20/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class ExperianceTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLbl: UILabel!
    @IBOutlet weak var workLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
