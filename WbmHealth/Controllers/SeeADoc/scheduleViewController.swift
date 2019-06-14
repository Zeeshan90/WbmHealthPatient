//
//  scheduleViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/9/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class scheduleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func findADoc(_ sender: Any) {
        performSegue(withIdentifier: "tospeciality", sender: self)
    }
    
    @IBAction func findATime(_ sender: Any) {
    }
    
}
