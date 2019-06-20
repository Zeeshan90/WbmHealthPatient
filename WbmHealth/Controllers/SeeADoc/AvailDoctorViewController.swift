
//
//  AvailDoctorViewController.swift
//  WbmHealth
//
//  Created by Zeeshan on 18/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD
class AvailDoctorViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    let reason:String = WbmDefaults.instance.getString(key: "reason")
    var docArr = [Doctor]()
    
    @IBOutlet weak var docTblVu: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProgressHUD.show()
        getDoctors()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = docTblVu.dequeueReusableCell(withIdentifier: "doctorcell", for: indexPath) as! AvailDoctorTableViewCell
        
        let imgUrl = "\(AppUtils.returnBaseUrl())\(docArr[indexPath.row].image.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "h")"
        cell.setData(name: docArr[indexPath.row].doctorName, imag: imgUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 137
    }
    
    func getDoctors(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/reason/spec/doctor"
        Alamofire.request(url, method: .post, parameters: ["reason":reason]).responseJSON{
            
            response in
            
            ProgressHUD.dismiss()
            if response.result.isSuccess{
                let json: JSON = JSON(response.result.value!)
                print(json)
                for (_,j) in json{
                    do{
                        self.docArr.append(Doctor(fromJson: j))
                    }
                }
                
                DispatchQueue.main.async {
                    self.docTblVu.reloadData()
                }
                
                
            }else{
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }

}
