//
//  VerifyCodeViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/14/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import TuyaSmartBaseKit
class VerifyCodeViewController: UIViewController {
    
    @IBOutlet weak var txtFld4: UITextField!
    @IBOutlet weak var txtFld3: UITextField!
    @IBOutlet weak var txtFld2: UITextField!
    @IBOutlet weak var txtFld1: UITextField!
    @IBOutlet weak var txtFld5: UITextField!
    @IBOutlet weak var txtFld6: UITextField!
    var code: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFld1.addTarget(self, action: #selector(self.textdidChange(textField:)), for: .editingChanged)
        txtFld2.addTarget(self, action: #selector(self.textdidChange(textField:)), for: .editingChanged)
        txtFld3.addTarget(self, action: #selector(self.textdidChange(textField:)), for: .editingChanged)
        txtFld4.addTarget(self, action: #selector(self.textdidChange(textField:)), for: .editingChanged)
        txtFld5.addTarget(self, action: #selector(self.textdidChange(textField:)), for: .editingChanged)
        txtFld6.addTarget(self, action: #selector(self.textdidChange(textField:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        txtFld1.becomeFirstResponder()
    }

    @objc func textdidChange(textField: UITextField){
        let text = textField.text
        
        if text?.utf16.count == 1{
            switch textField{
            case txtFld1:
                txtFld2.becomeFirstResponder()
                break
                
            case txtFld2:
                txtFld3.becomeFirstResponder()
                break
                
            case txtFld3:
                txtFld4.becomeFirstResponder()
                break
                
            case txtFld4:
                txtFld5.becomeFirstResponder()
                break
            case txtFld5:
                txtFld6.becomeFirstResponder()
                break
            case txtFld6:
                
                txtFld6.resignFirstResponder()
                code = txtFld1.text! + txtFld2.text! + txtFld3.text! + txtFld4.text! + txtFld5.text! + txtFld6.text!
                print(code)
                WbmDefaults.instance.setString(key: "verifycode", value: code)
                performSegue(withIdentifier: "topassword", sender: self)
                break
            default:
                break
            }
        }
        else{
            
        }
    }
    
}
