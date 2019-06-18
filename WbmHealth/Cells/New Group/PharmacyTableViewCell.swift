//
//  PharmacyTableViewCell.swift
//  WbmHealth
//
//  Created by Zeeshan on 13/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class PharmacyTableViewCell: UITableViewCell {

    @IBOutlet weak var pharName: UILabel!
    @IBOutlet weak var pharImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(name: String, imag: String){
        pharName.text = name
        pharImg.downloaded(from: imag)
        
    }

}
