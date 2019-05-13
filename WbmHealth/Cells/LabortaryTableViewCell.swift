//
//  LabortaryTableViewCell.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class LabortaryTableViewCell: UITableViewCell {

    @IBOutlet weak var labortaryName: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(text: String,imag:String)  {
        labortaryName.text = text
        
    }

}
