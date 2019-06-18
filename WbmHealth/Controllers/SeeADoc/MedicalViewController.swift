//
//  MedicalViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class MedicalViewController: UIViewController,UITableViewDelegate
,UITableViewDataSource{
    
    

    @IBOutlet weak var medicalTblVu: UITableView!
    var medConArr = [MedicalCondition]()
    override func viewDidLoad() {
        super.viewDidLoad()

        ProgressHUD.show("Please wait")
        getmedicalConditions()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medConArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = medicalTblVu.dequeueReusableCell(withIdentifier: "medicalcell", for: indexPath) as! MedicalTableViewCell
        cell.nameLbl.text = medConArr[indexPath.row].text
        return cell
    }
    @IBAction func saveBtn(_ sender: Any) {
         self.navigationController?.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if medicalTblVu.cellForRow(at: indexPath)?.accessoryType == UITableViewCell
            .AccessoryType.checkmark{
            medicalTblVu.cellForRow(at: indexPath)?.accessoryType = UITableViewCell
                .AccessoryType.none
        }else{
            medicalTblVu.cellForRow(at: indexPath)?.accessoryType = UITableViewCell
                .AccessoryType.checkmark
        }
    }
    
    func getmedicalConditions(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/init/dodmedconditions"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            ProgressHUD.dismiss()
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                let resultJson = json["result"]
                print(resultJson)
                
                for (_,j) in resultJson{
                    
                    let medCon = MedicalCondition(fromJson: j)
                    self.medConArr.append(medCon)
                }
                
                DispatchQueue.main.async {
                    self.medicalTblVu.reloadData()
                }
                
            }else{
                print(response.error?.localizedDescription as Any)
            }
        }
    }

}