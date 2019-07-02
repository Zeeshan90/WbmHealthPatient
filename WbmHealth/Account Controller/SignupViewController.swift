//
//  SignupViewController.swift
//  WbmHealth
//
//  Created by Zeeshan on 02/07/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func dismissBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func signUpPatient(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/signup"
        Alamofire.request(url, method: .post, parameters: nil).responseJSON{
            
            response in
            
            if response.result.isSuccess{
                print(response.result.value)
            }else{
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
}
