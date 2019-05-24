//
//  LoginViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/14/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import TuyaSmartBaseKit
class LoginViewController: UIViewController {

    @IBOutlet weak var mobemailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        
    }
    
    @IBAction func verifyCodeLogin(_ sender: Any) {
        
    }
    @IBAction func registerBtn(_ sender: Any) {
        performSegue(withIdentifier: "registeremail", sender: self)
    }
    
    @IBAction func login(_ sender: Any) {
        loginByEmail()
    }
    func loginByEmail() {
        TuyaSmartUser.sharedInstance()?.login(byEmail: "92", email: mobemailTxtFld.text!, password: passwordTxtFld.text!, success: {
            print("login success")
            self.performSegue(withIdentifier: "createfamily", sender: self)
        }, failure: { (error) in
            if let e = error {
                self.getAlert(message: "Enter Valid credentials", title: "Wrong Credientials")
                print("login failure: \(e)")
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
