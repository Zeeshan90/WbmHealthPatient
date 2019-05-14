//
//  PasswordViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/14/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import TuyaSmartBaseKit
class PasswordViewController: UIViewController {

    @IBOutlet weak var passTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func completeBtn(_ sender: Any) {
        
        registerByEmail()
    }
    
    func registerByEmail() {
        let email = WbmDefaults.instance.getString(key: "regemail")
        let code = WbmDefaults.instance.getString(key: "verifycode")
        TuyaSmartUser.sharedInstance()?.register(byEmail: "92", email: email, password: passTxtFld.text!, code: code, success: {
            print("register success")
        }, failure: { (error) in
            if let e = error {
                print("register failure: \(e)")
            }
        })
    }
}
