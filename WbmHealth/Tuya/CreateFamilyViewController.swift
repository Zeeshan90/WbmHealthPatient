//
//  CreateFamilyViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/14/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import TuyaSmartBaseKit
class CreateFamilyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createFamily(_ sender: Any) {
        performSegue(withIdentifier: "addfamily", sender: self)
    }
    
    @IBAction func logout(_ sender: Any) {
        loginOut()
    }
    
    
    func loginOut() {
        TuyaSmartUser.sharedInstance()?.loginOut({
            print("logOut success")
        }, failure: { (error) in
            if let e = error {
                print("logOut failure: \(e)")
            }
        })
    }
}
