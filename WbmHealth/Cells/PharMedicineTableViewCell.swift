//
//  PharMedicineTableViewCell.swift
//  WbmHealth
//
//  Created by Zeeshan on 14/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class PharMedicineTableViewCell: UITableViewCell {

    @IBOutlet weak var medImg: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(medName: String,description: String, price: String,photo: String){
        nameLbl.text = medName
        descriptionLbl.text = description
        priceLbl.text = "Price: " + price + " RS"
        medImg.downloaded(from: photo)
    }
}
