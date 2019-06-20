//
//  SymptomsViewController.swift
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
class SymptomsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var symptomTblVu: UITableView!
    
    var symptomArr = [Symptom]()
    var selectedSymptomArr = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show("Please wait")
        getSymptoms()
        // Do any additional setup after loading the view.
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = symptomTblVu.dequeueReusableCell(withIdentifier: "symptomcell", for: indexPath) as! SymptomsTableViewCell
        
        // let checkBoxClick = UITapGestureRecognizer(target: self, action: #selector(checkBox(_:)))
        //cell.checkBox.addGestureRecognizer(checkBoxClick)
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(checkBox(_:)), for: .valueChanged)
        cell.nameLbl.text = symptomArr[indexPath.row].text
        return cell
    }
    
    @objc func checkBox(_ check: M13Checkbox){
        print(check.tag)
        
        switch check.checkState{
        case .checked:
            selectedSymptomArr.append(symptomArr[check.tag].text)
            print(selectedSymptomArr)
            break
        case .unchecked:
            
            if let index = selectedSymptomArr.index(of: symptomArr[check.tag].text) {
                selectedSymptomArr.remove(at: index)
            }
            print(selectedSymptomArr)
            break
        case .mixed:
            break
        }
        
        
    }
    
    

    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if symptomTblVu.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
//
//            symptomTblVu.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
//
//        }else{
//            symptomTblVu.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
//            selectedSymptomArr.append(symptomArr[indexPath.row].text)
//        }
//    }
    
    @IBAction func nextBtn(_ sender: Any) {
        performSegue(withIdentifier: "tomedical", sender: self)
    }
    
    func getSymptoms(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/init/dodsymptoms"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            ProgressHUD.dismiss()
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                let resultJson = json["result"]
                print(resultJson)
                
                for (_,j) in resultJson{
                    
                    let symptomJson = Symptom(fromJson: j)
                    self.symptomArr.append(symptomJson)
                }
                
                DispatchQueue.main.async {
                    self.symptomTblVu.reloadData()
                }
                
            }else{
                
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
}
