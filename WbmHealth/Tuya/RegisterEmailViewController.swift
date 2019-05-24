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

    @IBOutlet weak var regemailLbl: UILabel!
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var registerEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func obtainVerifyCode(_ sender: Any) {
        sendVerifyCode()
      
    }
    @IBAction func crossBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        
//        if segments.selectedSegmentIndex == 0{
//            regemailLbl.text = "Register By Email"
//            registerEmail.placeholder = "Email"
//        }
//        if segments.selectedSegmentIndex == 1{
//            regemailLbl.text = "Register By Phone}"
//            registerEmail.placeholder = "Number"
//        }
    }
    func sendVerifyCode() {
        
        TuyaSmartUser.sharedInstance()?.sendVerifyCode(byRegisterEmail: "92", email: registerEmail.text, success: {
            print("sendVerifyCode success")
              self.performSegue(withIdentifier: "verifycode", sender: self)
            WbmDefaults.instance.setString(key: "regemail", value: self.registerEmail.text ?? "")
        }, failure: { (error) in
            if let e = error {
                self.getAlert(message: "Network Error", title: "Failure")
                print("sendVerifyCode failure: \(e)")
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
