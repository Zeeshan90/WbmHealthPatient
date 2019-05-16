//
//  DoctorBioViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/13/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class DoctorBioViewController: UIViewController {

    @IBOutlet weak var availabilityVu: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let availableClick = UITapGestureRecognizer(target: self, action: #selector(tapOnAvailable))
        availabilityVu.addGestureRecognizer(availableClick)
        // Do any additional setup after loading the view.
    }
    
    @objc func tapOnAvailable(){
        performSegue(withIdentifier: "toavailble", sender: self)
    }
    

}
