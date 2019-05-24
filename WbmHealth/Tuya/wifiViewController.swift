//
//  wifiViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/23/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import TuyaSmartUtil
import TuyaSmartBaseKit
import TuyaSmartSceneKit

class wifiViewController: UIViewController {
    
    @IBOutlet weak var wifiPasssword: TextField!
    @IBOutlet weak var wifiLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        wifiLbl.text = fetchSSIDInfo()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func continueBtn(_ sender: Any) {
        WbmDefaults.instance.setString(key: "wifiname", value: wifiLbl.text!)
        WbmDefaults.instance.setString(key: "wifipassword", value: wifiPasssword.text ?? "test")
        performSegue(withIdentifier: "tosearch", sender: self)
    }
    
    
    
    func fetchSSIDInfo() -> String? {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
    
}
