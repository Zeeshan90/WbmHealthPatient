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
import M13Checkbox
class MedicalViewController: UIViewController,UITableViewDelegate
,UITableViewDataSource{
    
    

    @IBOutlet weak var medicalTblVu: UITableView!
    var medConArr = [MedicalCondition]()
    var selectedMedConArr = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        medicalTblVu.tableFooterView = UIView()
        ProgressHUD.show("Please wait")
        getmedicalConditions()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medConArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = medicalTblVu.dequeueReusableCell(withIdentifier: "medicalcell", for: indexPath) as! MedicalTableViewCell
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(checkBox(_:)), for: .valueChanged)
        cell.nameLbl.text = medConArr[indexPath.row].text
        return cell
    }
    
    @objc func checkBox(_ check: M13Checkbox){
        
        switch check.checkState{
        case .unchecked:
            
            if let index = selectedMedConArr.index(of: medConArr[check.tag].text) {
                selectedMedConArr.remove(at: index)
            }
            print(selectedMedConArr)
            break
        case .checked:
            selectedMedConArr.append(medConArr[check.tag].text)
            print(selectedMedConArr)
            
            
            break
        case .mixed:
            print("mixed")
            break
        }
    }
    @IBAction func saveBtn(_ sender: Any) {
         performSegue(withIdentifier: "todoctors", sender: self)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if medicalTblVu.cellForRow(at: indexPath)?.accessoryType == UITableViewCell
//            .AccessoryType.checkmark{
//            medicalTblVu.cellForRow(at: indexPath)?.accessoryType = UITableViewCell
//                .AccessoryType.none
//        }else{
//            medicalTblVu.cellForRow(at: indexPath)?.accessoryType = UITableViewCell
//                .AccessoryType.checkmark
//        }
//    }
//
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
