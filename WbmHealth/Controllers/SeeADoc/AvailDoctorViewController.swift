
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
    var directCallArr = [DirectCall]()
    var docId: String       = ""
    var docToken: String    = ""
    var appointId: String   = ""
    var vidyoToken: String  = ""
    var resourceId: String  = ""
    let date = Date()
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
        cell.callBtn.tag = indexPath.row
        cell.callBtn.addTarget(self, action: #selector(callBtnPressed(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func callBtnPressed(sender: UIButton){
        ProgressHUD.show("Please Wait.. we are connecting you to doctor")
        docId = docArr[sender.tag].id
        docToken = docArr[sender.tag].docToken
        makeAppointment(docId: docId)
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
                ProgressHUD.dismiss()
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }

}

// Mark -> Getting data for direct Call
extension AvailDoctorViewController{
    
    // Making Appointment
    func makeAppointment(docId: String){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/my/appot/make"
        let params = [
            "appointment":[
            "apptDate": date,
            "apptTime": "8:10",
            "patient": Utils.userId,
            "doctor": docId,
            "apptReason": "Emergency Call",
            "status": "Complete",
            "directCall": "directCall",
            "email": "random@gmail.com",
            "resourceId": ""
                ],
            "notification": [
                "intervals": "",
                "date": "",
                "doctorId": ""
            ]
        ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params).responseJSON{
            
            response in
            
            if response.result.isSuccess{
                print(response.result.value!)
                self.directCall()
                
            }else{
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
    
//    // Getting Doc Data // Send Doc Id
//    func getDocData(){
//        let url = "\(AppUtils.returnBaseUrl())/patient/doctor"
//        Alamofire.request(url, method: .post, parameters: nil).responseJSON{
//            
//            response in
//            
//            if response.result.isSuccess{
//                
//                let json:JSON = JSON(response.result.value)
//                print(response.result.value!)
//            }else{
//                ProgressHUD.dismiss()
//                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
//            }
//        }
//    }
    
    // Getting the newly Generated Appointment Id
    // Send PatientId with the url
    func directCall(){
        let url = "\(AppUtils.returnBaseUrl())/patient/call/direct/" + Utils.userId
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            
            response in
            
            if response.result.isSuccess{
                
                let json:JSON = JSON(response.result.value!)
                print(json)
                self.appointId = json["_id"].stringValue
//
//                    for (_,j) in json{
//                        do{
//                            self.directCallArr.append(DirectCall(fromJson: j))
//                        }
//                    }
                
//
//                    let count = self.directCallArr.count
//                    let lastIndex = count - 1
//                    print(self.directCallArr[lastIndex].id)
//                    self.appointId = self.directCallArr[lastIndex].id
                    self.updateDirectCall()
                
                
            }else{
                ProgressHUD.dismiss()
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
    
    // Setting the Direct Call to make call.
    // Parameters : AnyThing
    func updateDirectCall(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/call/direct/update/" + appointId
        Alamofire.request(url, method: .put, parameters: ["url1":""]).responseJSON{
            response in
            
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                print(json)
                self.getResourceId()
            }else{
                ProgressHUD.dismiss()
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
}

// Mark -> Getting the variables for the vidyo.io
extension AvailDoctorViewController{
    
    // Getting the token
    func getVidyoToken(){
        
        let url = "\(AppUtils.returnBaseUrl())/vidyo/token"
        Alamofire.request(url, method: .post, parameters: ["name":"test"]).responseJSON{
            response in
            
            if response.result.isSuccess{
                print(response.result.value!)
                self.vidyoToken = (response.result.value!) as! String
                ProgressHUD.dismiss()
                // Mark -> Vidyo View controller Loading
                let rootController = UIStoryboard(name: "vid", bundle: nil).instantiateViewController(withIdentifier: "VidyoViewController") as! VidyoViewController
                rootController.VIDYO_TOKEN = self.vidyoToken
                rootController.resourceID = self.resourceId
                self.navigationController?.present(rootController, animated: true, completion: nil)
            }else{
                ProgressHUD.dismiss()
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
    
    // Getting the resource Id
    func getResourceId(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/call/setid/" + appointId
        Alamofire.request(url, method: .put, parameters: ["resource":""]).responseJSON{
            response in
            
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                print(json)
                self.resourceId = json["resourceId"].stringValue
                self.getVidyoToken()
            }else{
                ProgressHUD.dismiss()
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
}
