//
//  MedicalHistoryCollectionViewCell.swift
//  WbmHealth
//
//  Created by WBM on 4/30/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class MedicalHistoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var vu: UIView!
    
    
    func setdata(name: String,imag: String){
        nameLbl.text = name
        img.image = UIImage(named: imag)
    }
}
