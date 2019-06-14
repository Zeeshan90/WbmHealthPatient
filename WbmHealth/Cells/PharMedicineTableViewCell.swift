//
//  PharMedicineTableViewCell.swift
//  WbmHealth
//
//  Created by Zeeshan on 14/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class PharMedicineTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(medName: String){
        nameLbl.text = medName
    }
}
