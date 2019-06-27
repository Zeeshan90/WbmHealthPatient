//
//  CartTableViewCell.swift
//  WbmHealth
//
//  Created by Zeeshan on 24/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(name: String,imgUrl: String,price: String){
        
        productName.text = name
        productPrice.text = price
        productImg.downloaded(from: imgUrl)
        
    }
}
