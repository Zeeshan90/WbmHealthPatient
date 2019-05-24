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
         self.performSegue(withIdentifier: "tomain", sender: self)
        }, failure: { (error) in
            if let e = error {
                self.getAlert(message: "\(e)", title: "Failure")
                print("register failure: \(e)")
            }
        })
    }
    
    
    func getAlert(message:String?,title:String?){
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
