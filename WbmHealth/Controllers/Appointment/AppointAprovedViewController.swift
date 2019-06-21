//
//  AppointAprovedViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/2/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD
class AppointAprovedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    var appointArr = [ConfirmAppoint]()
    @IBOutlet weak var aprrovedAppointTblVu: UITableView!
    let util = Utils()
    let dateFormatter = DateFormatter()
    var resourceId: String!
    var vidyoToken: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        getAppointments()
        ProgressHUD.show("Please wait")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if appointArr.count == 0{
            self.aprrovedAppointTblVu.setEmptyMessage("No Approved Appointments Yet")
        }else{
            self.aprrovedAppointTblVu.restore()
            
        }
        return appointArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = aprrovedAppointTblVu.dequeueReusableCell(withIdentifier: "appointcell", for: indexPath) as! ConfirmAppointTableViewCell
        cell.nameLbl.text = "WBM Health"
        let docName: String = appointArr[indexPath.row].doctorName.uppercased()
        
        let appointDate:Date = util.convertLongString(date: appointArr[indexPath.row].apptDate)
        let appointDateStr: String = util.convertShortDate(date: appointDate)
        let apointTime: String = appointArr[indexPath.row].apptTime
        let appointReason: String = appointArr[indexPath.row].apptReason
        cell.descriptionLbl.text = "we have booked \(docName) for your checkup on \(appointDateStr) at \(apointTime) for the following reason \(appointReason)"
        util.cardView(view: cell.Vu)
        cell.callBtn.layer.cornerRadius = cell.callBtn.frame.height/2
        cell.callBtn.tag = indexPath.row
        cell.callBtn.addTarget(self, action: #selector(callBtnPressed(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func callBtnPressed(sender: UIButton){
        
        resourceId = appointArr[sender.tag].id
        getResourceId()
      
    }

    @IBAction func crossBtn(_ sender: Any) {
        ProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    
 
    

    
    // Get All Appointment
    func getAppointments(){
        appointArr = [ConfirmAppoint]()
        let url = "\(AppUtils.returnBaseUrl())/patient/appointment/status/accepted/all/5c94754e0948dd2edcb4c299"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            ProgressHUD.dismiss()
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                let resultJson = json["result"]
                print(resultJson)
                
                for (_,j) in resultJson{
                    do {
                        let appointjson = ConfirmAppoint(fromJson: j)
                        self.appointArr.append(appointjson)
                    }
                }
                DispatchQueue.main.async {
                    self.aprrovedAppointTblVu.reloadData()
                }
                
            }else{
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VidyoViewController"{
            
        }
    }
    

}


// Mark -> Getting the variables for the vidyo.io
extension AppointAprovedViewController{
    
    // Getting the token
    func getVidyoToken(){
        
        let url = "\(AppUtils.returnBaseUrl())/vidyo/token"
        Alamofire.request(url, method: .post, parameters: ["name":"test"]).responseJSON{
            response in
            
            if response.result.isSuccess{
                print(response.result.value!)
                self.vidyoToken = response.result.value! as? String
                
                // Mark -> Vidyo View controller Loading
                let rootController = UIStoryboard(name: "vid", bundle: nil).instantiateViewController(withIdentifier: "VidyoViewController") as! VidyoViewController
                rootController.VIDYO_TOKEN = self.vidyoToken
                rootController.resourceID = self.resourceId
                self.navigationController?.present(rootController, animated: true, completion: nil)
            }else{
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
    
    // Getting the resource Id
    func getResourceId(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/call/setid/" + resourceId
        Alamofire.request(url, method: .put, parameters: ["resourceId":resourceId]).responseJSON{
            response in
            
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                print(json)
                self.resourceId = json["resourceId"].stringValue
                self.getVidyoToken()
            }else{
                
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
}
