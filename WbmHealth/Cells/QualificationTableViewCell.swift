//
//  QualificationTableViewCell.swift
//  WbmHealth
//
//  Created by WBM on 5/20/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class QualificationTableViewCell: UITableViewCell {

    @IBOutlet weak var specialityLbl: UILabel!
    @IBOutlet weak var qualificationLbl: UILabel!
    @IBOutlet weak var instituteLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
