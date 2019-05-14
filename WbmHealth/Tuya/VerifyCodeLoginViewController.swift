//
//  VerifyCodeLoginViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/14/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import TuyaSmartBaseKit

class VerifyCodeLoginViewController: UIViewController {

    @IBOutlet weak var numEmailTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func verifyCode(_ sender: Any) {
        
    }
    
    func sendVerifyCode() {
        TuyaSmartUser.sharedInstance()?.sendVerifyCode("your_country_code", phoneNumber: "your_phone_number", type: 0, success: {
            print("sendVerifyCode success")
        }, failure: { (error) in
            if let e = error {
                print("sendVerifyCode failure: \(e)")
            }
        })
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
