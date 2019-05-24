//
//  SerachViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/23/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SystemConfiguration.CaptiveNetwork
import TuyaSmartUtil
import TuyaSmartBaseKit
import TuyaSmartSceneKit

class SerachViewController: UIViewController,TuyaSmartActivatorDelegate {

    
    
    let hId = WbmDefaults.instance.getInt(key: "homeId")
    var home: TuyaSmartHome?
    @IBOutlet weak var searching: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searching.type = .ballClipRotateMultiple
        searching.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        searching.startAnimating()
        getToken()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getToken() {
        
        let wifiName = WbmDefaults.instance.getString(key: "wifiname")
        let wifipass = WbmDefaults.instance.getString(key: "wifipassword")
        TuyaSmartActivator.sharedInstance()?.getTokenWithHomeId(Int64(hId), success: { (token) in
            print("getToken success: \(token!)")
            // TODO: startConfigWiFi
            self.startConfigWiFi(withSsid: wifiName, password: wifipass, token: token!)
        }, failure: { (error) in
            if let e = error {
                print("getToken failure: \(e)")
            }
        })
    }
    
    func startConfigWiFi(withSsid ssid: String, password: String, token: String) {
        // Set TuyaSmartActivator delegate，impl delegate method
        TuyaSmartActivator.sharedInstance()?.delegate = self
        
        // start activator
        TuyaSmartActivator.sharedInstance()?.startConfigWiFi(TYActivatorModeEZ, ssid: ssid, password: password, token: token, timeout: 100)
    }
    
    func activator(_ activator: TuyaSmartActivator!, didReceiveDevice deviceModel: TuyaSmartDeviceModel!, error: Error!) {
        if deviceModel != nil && error == nil {
            //active success\
            
            print(deviceModel.name)
            print(deviceModel.uiId)
        }
        
        if let e = error {
            //active failure
            print("\(e)")
        }
    }

}

extension SerachViewController: TuyaSmartHomeDelegate {
    
    
    func initHome() {
        home = TuyaSmartHome(homeId: Int64(hId))
        home?.delegate = self
    }
    
    // Update information of home, such as name.
    func homeDidUpdateInfo(_ home: TuyaSmartHome!) {
        //        reload()
    }
    // The change of relation between home and room.
    func homeDidUpdateRoomInfo(_ home: TuyaSmartHome!) {
        //        reload()
    }
    
    // Received change of shared device list.
    func homeDidUpdateSharedInfo(_ home: TuyaSmartHome!) {
        
    }
    
    // room information change, such as name.
    func home(_ home: TuyaSmartHome!, roomInfoUpdate room: TuyaSmartRoomModel!) {
        //        reload()/
    }
    
    // The change of relation between  room and devices and group.
    func home(_ home: TuyaSmartHome!, roomRelationUpdate room: TuyaSmartRoomModel!) {
        
    }
    
    // Add device
    func home(_ home: TuyaSmartHome!, didAddDeivice device: TuyaSmartDeviceModel!) {
        print (device.name)
    }
    
    // Remove Device
    func home(_ home: TuyaSmartHome!, didRemoveDeivice devId: String!) {
        
    }
    
    // Update information of device, such as name.
    func home(_ home: TuyaSmartHome!, deviceInfoUpdate device: TuyaSmartDeviceModel!) {
        
    }
    
    // Update dp data of device.
    func home(_ home: TuyaSmartHome!, group: TuyaSmartGroupModel!, dpsUpdate dps: [AnyHashable : Any]!) {
        
    }
    
    // Add group.
    func home(_ home: TuyaSmartHome!, didAddGroup group: TuyaSmartGroupModel!) {
        
    }
    
    // Remove group.
    func home(_ home: TuyaSmartHome!, didRemoveGroup groupId: String!) {
        
    }
    
    // Update information of group, such as name.
    func home(_ home: TuyaSmartHome!, groupInfoUpdate group: TuyaSmartGroupModel!) {
        
    }
    
}
