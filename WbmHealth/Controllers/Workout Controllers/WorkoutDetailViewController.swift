//
//  WorkoutDetailViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import SwiftGifOrigin
class WorkoutDetailViewController: UIViewController {

    @IBOutlet weak var stepsLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var upperVu: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        cardView(view: upperVu)
        img.loadGif(asset: "gif1")
        // Do any additional setup after loading the view.
    }
    
    /// CardView
    func cardView(view:UIView){
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1
        view.layer.cornerRadius = 10
    }

}
