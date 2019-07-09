//
//  AppointPendingViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/2/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD
class AppointPendingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   

    var pendingArr = [ConfirmAppoint]()
    let util = Utils()
    @IBOutlet weak var pendingTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPendingAppoint()
        ProgressHUD.show("Please wait")
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if pendingArr.count == 0{
            self.pendingTblVu.setEmptyMessage("No Pending Appointments")
        }else{
            self.pendingTblVu.restore()
            
        }
        return pendingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pendingTblVu.dequeueReusableCell(withIdentifier: "pendingcell", for: indexPath) as! PendingTableViewCell
        cell.doctorNameLbl.text = "Doctor: \(pendingArr[indexPath.row].doctorName!.uppercased())"
        
        let appointDate:Date = util.convertLongString(date: pendingArr[indexPath.row].apptDate)
        let appointDateStr: String = util.convertShortDate(date: appointDate)
        cell.dateLbl.text = "Date: \(appointDateStr)"
        
        
        let timeStr = pendingArr[indexPath.row].apptTime!
        let time = timeStr.replacingOccurrences(of: ".", with: ":")
        cell.TimeLbl.text = "Time: \(time)"
        cell.chargesLbl.text = "Charges: $$$"
        Utils.cardView(view: cell.vu)
        cell.cancelBtn.tag = indexPath.row
        cell.cancelBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        cell.cancelBtn.layer.cornerRadius = 5
        
        return cell
    }
    

    @objc func btnClick(sender: UIButton){
        
        let selectedCell = sender.tag
        let selectedId = pendingArr[selectedCell].id
        // create the alert
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: {action in
            
            self.cancelAppoint(indexId: selectedId!)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    @IBAction func crossBtn(_ sender: Any) {
        ProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    
    func cancelAppoint(indexId: String){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/my/appointment/cancel/\(indexId)"
        Alamofire.request(url, method: .put, parameters: nil).responseJSON{
            response in
            
            if response.result.isSuccess{
                self.getPendingAppoint()
            }else{
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
    
    // Getting Pending Appointments from the server
    func getPendingAppoint(){
        pendingArr = [ConfirmAppoint]()
        let url = "\(AppUtils.returnBaseUrl())/patient/appointment/status/pending/all/" + Utils.userId
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            
            response in
            
            if response.result.isSuccess{
                let json: JSON = JSON(response.result.value!)
                let resultJson = json["result"]
                print(resultJson)
                ProgressHUD.dismiss()
                for (_,j) in resultJson{
                    do{
                        let pendingJson = ConfirmAppoint(fromJson: j)
                        self.pendingArr.append(pendingJson)
                    }
                }
                
                DispatchQueue.main.async {
                    self.pendingTblVu.reloadData()
                }
                
            }else{
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
        
    }
}
