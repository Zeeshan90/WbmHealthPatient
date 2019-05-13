//
//  SeeDocTableViewCell.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class SeeDocTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(text: String, imgg:String){
        nameLbl.text = text
        img.image = UIImage(named: imgg)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
