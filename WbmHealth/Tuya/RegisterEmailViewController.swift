//
//  RegisterEmailViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/14/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import TuyaSmartBaseKit
class RegisterEmailViewController: UIViewController {

    @IBOutlet weak var registerEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func obtainVerifyCode(_ sender: Any) {
       sendVerifyCode()
        performSegue(withIdentifier: "verifycode", sender: self)
    }
    
    func sendVerifyCode() {
        TuyaSmartUser.sharedInstance()?.sendVerifyCode(byRegisterEmail: "92", email: registerEmail.text, success: {
            print("sendVerifyCode success")
            WbmDefaults.instance.setString(key: "regemail", value: self.registerEmail.text ?? "")
        }, failure: { (error) in
            if let e = error {
                print("sendVerifyCode failure: \(e)")
            }
        })
    }
}
