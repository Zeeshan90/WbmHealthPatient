//
//  HospitalTableViewCell.swift
//  
//
//  Created by WBM on 4/29/19.
//

import UIKit

class HospitalTableViewCell: UITableViewCell {

    @IBOutlet weak var hospName: UILabel!
    @IBOutlet weak var hospImg: UIImageView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(hospiName: String,hospiImg: String,address: String){
        hospName.text = hospiName
        addressLbl.text = address
        hospImg.downloaded(from: hospiImg)
    }

}
