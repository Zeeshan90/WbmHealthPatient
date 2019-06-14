//
//  DoctorViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/13/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DoctorViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var doctorArr = [Doctor]()
    @IBOutlet weak var doctorTblVu: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDoctors()
        doctorTblVu.showSkeleton()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if doctorArr.count == 0{
            self.doctorTblVu.setEmptyMessage("No Doctor available")
        }else{
            self.doctorTblVu.restore()
            
        }

        return doctorArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = doctorTblVu.dequeueReusableCell(withIdentifier: "doctorcell", for: indexPath) as! DoctorTableViewCell
        cell.doctorNamelbl.text = doctorArr[indexPath.row].doctorName
        cell.languageLbl.text = doctorArr[indexPath.row].languageLbl
        cell.availabilityLbl.text = doctorArr[indexPath.row].availableLbl
        cell.doctorImg.layer.cornerRadius = cell.doctorImg.frame.height/2
        cell.doctorImg.downloaded(from: "\(AppUtils.returnBaseUrl())\(doctorArr[indexPath.row].image!)")
        return cell
    }
   

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let docId:String = doctorArr[indexPath.row].id
        WbmDefaults.instance.setString(key: "docId", value: docId)
        AppointmentViewController.request.doctorId = docId              // Saving Doctor Id in AppointRequest variable
        performSegue(withIdentifier: "doctorbio", sender: self)
        doctorTblVu.deselectRow(at: indexPath, animated: true)
    }
    
    func getDoctors(){
        let specialityId = WbmDefaults.instance.getString(key: "specialityId")
        let url = "\(AppUtils.returnBaseUrl())/patient/spec/doctors/\(specialityId)"
        Alamofire.request(url, method: .get).responseJSON{
            response in
            
            if response.result.isSuccess{
                self.doctorTblVu.hideSkeleton()
                let json = JSON(response.result.value!)
                print(json)
                
                for (_,j) in json{
                    do{
                        self.doctorArr.append(Doctor(fromJson: j))
                    }
                }
                
                DispatchQueue.main.async {
                    self.doctorTblVu.reloadData()
                }
            }
            else{
                print("Error: \(response.error as Any)")
            }
        }
        
    }
}
