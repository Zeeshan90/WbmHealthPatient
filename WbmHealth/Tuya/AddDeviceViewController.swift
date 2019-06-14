//
//  AddDeviceViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/22/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import TuyaSmartUtil
import TuyaSmartBaseKit
import TuyaSmartSceneKit
import SystemConfiguration.CaptiveNetwork

class AddDeviceViewController: UIViewController {
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    var device: TuyaSmartDevice?
    var request = TuyaSmartRequest()
    @IBOutlet weak var addDevice: UIButton!
    let hId = WbmDefaults.instance.getInt(key: "homeId")
    override func viewDidLoad() {
        super.viewDidLoad()
       getTestDevice()
        // Do any additional setup after loading the view.
    }
    @IBAction func addDeviceBtn(_ sender: Any) {
       
        performSegue(withIdentifier: "towifi", sender: self)
        
    }
    
    func getTestDevice() {
        
        request.request(withApiName: "s.m.dev.sdk.demo.list", postData: nil, version: "1.0", success: { (list) in
            
            
        }, failure: { (error) in
            if let e = error {
                print("getToken failure: \(e)")
            }
        })
    }
    
    @IBAction func removedevice(_ sender: Any) {
        removeDevice()
    }
    
    
    func removeDevice() {
        device?.remove({
            print("remove success")
        }, failure: { (error) in
            if let e = error {
                print("remove failure: \(e)")
            }
        })
    }

}
