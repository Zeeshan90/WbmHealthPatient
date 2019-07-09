//
//  MainViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/26/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import LGSideMenuController

class MainViewController: LGSideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mainViewController = storyboard.instantiateViewController(withIdentifier: "mainView") as! MainViewController
//        mainViewController.leftViewPresentationStyle = .slideBelow
        leftViewPresentationStyle = .scaleFromLittle
        leftViewBackgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.95)
    }

}
