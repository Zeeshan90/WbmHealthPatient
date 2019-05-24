//
//  DeviceListViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/22/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import TuyaSmartUtil
import TuyaSmartDeviceKit
class DeviceListViewController: UIViewController,TuyaSmartHomeManagerDelegate,TuyaSmartHomeDelegate,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var deviceList: UITableView!
    var request = TuyaSmartRequest()
    var homeManager = TuyaSmartHomeManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        homeManager.delegate = self
        getTestDevice()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = deviceList.dequeueReusableCell(withIdentifier: "", for: indexPath) as! DeviceListTableViewCell
        return cell
    }

    func getTestDevice() {
        
        request.request(withApiName: "s.m.dev.sdk.demo.list", postData: nil, version: "1.0", success: { (err) in
        
            
        }, failure: { (error) in
            if let e = error {
                print("getToken failure: \(e)")
            }
        })
    }
    // Update information of home, such as name.
    func homeDidUpdateInfo(_ home: TuyaSmartHome!) {
                deviceList.reloadData()
    }
    // The change of relation between home and room.
    func homeDidUpdateRoomInfo(_ home: TuyaSmartHome!) {
        //        reload()
         deviceList.reloadData()
    }
    
    // Received change of shared device list.
    func homeDidUpdateSharedInfo(_ home: TuyaSmartHome!) {
        
    }
    
    
    // Add device
    func home(_ home: TuyaSmartHome!, didAddDeivice device: TuyaSmartDeviceModel!) {
        print (device.name)
    }
    
    // Remove Device
    func home(_ home: TuyaSmartHome!, didRemoveDeivice devId: String!) {
         deviceList.reloadData()
    }
    
    // Update information of device, such as name.
    func home(_ home: TuyaSmartHome!, deviceInfoUpdate device: TuyaSmartDeviceModel!) {
         deviceList.reloadData()
    }
    
    // Update information of group, such as name.
    func home(_ home: TuyaSmartHome!, groupInfoUpdate group: TuyaSmartGroupModel!) {
        
    }


}
