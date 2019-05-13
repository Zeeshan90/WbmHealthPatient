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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateInitialViewController() as! MainViewController
        mainViewController.leftViewPresentationStyle = .slideBelow
        leftViewPresentationStyle = .scaleFromLittle
        leftViewBackgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.95)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
