//
//  LeftTableViewCell.swift
//  WbmHealth
//
//  Created by WBM on 4/26/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
