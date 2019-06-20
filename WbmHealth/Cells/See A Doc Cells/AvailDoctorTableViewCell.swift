//
//  AvailDoctorTableViewCell.swift
//  WbmHealth
//
//  Created by Zeeshan on 18/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class AvailDoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var docImg: UIImageView!
    @IBOutlet weak var docName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        docImg.layer.cornerRadius = docImg.frame.height/2
        callBtn.layer.cornerRadius = callBtn.frame.height/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(name: String, imag: String){
        
        docName.text = name
        docImg.downloaded(from: imag)
    }

}
