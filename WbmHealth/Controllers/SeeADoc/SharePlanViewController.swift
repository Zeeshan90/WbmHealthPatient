//
//  SharePlanViewController.swift
//  WbmHealth
//
//  Created by Zeeshan on 08/07/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SharePlanViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var shareTblVu: UITableView!
    var share: String = ""
    var careplanArr = [SharePlan]()
    var shareVaccinationArr = [Vaccination]()
    var medArr = [Medication]()
    override func viewDidLoad() {
        super.viewDidLoad()
        shareTblVu.tableFooterView = UIView()
        share = WbmDefaults.instance.getString(key: "checkValue")
        getdata(url: "\(AppUtils.returnBaseUrl())/patient/get/" + share + "/" + Utils.userId)
        navigationItem.title = share
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch share {
        case "careplan":
            return careplanArr.count
            
        case "vaccination":
            return shareVaccinationArr.count
            
        case "medication":
            return medArr.count
            
        default:
            return 0
           
        }
        
    }
    
    @objc func deletedPressed(_ sender: UIButton){
        print(sender.tag)
        
        switch share {
        case "careplan":
            careplanArr.remove(at: sender.tag)
            self.shareTblVu.reloadData()
            print(careplanArr)
            break
        case "vaccination":
            shareVaccinationArr.remove(at: sender.tag)
            self.shareTblVu.reloadData()
            print(shareVaccinationArr)
            break
        case "medication":
            medArr.remove(at: sender.tag)
            self.shareTblVu.reloadData()
            print(medArr)
            break
        default:
            dismiss(animated: true, completion: nil)
            break
            
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = shareTblVu.dequeueReusableCell(withIdentifier: "sharecell", for: indexPath) as! ShareTableViewCell
        Utils.cardView(view: cell.outerVu)
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deletedPressed(_:)), for: .touchUpInside)
        switch share {
        case "careplan":
            cell.frstLeftLbl.text = "Category"
            cell.frstRightLbl.text = careplanArr[indexPath.row].text
            
            cell.secondLeftLbl.text = "Period"
            cell.secondRightLbl.text = careplanArr[indexPath.row].period.start
            
            cell.thirdLeftLbl.text = "Status"
            cell.thirdRightLbl.text = careplanArr[indexPath.row].status
            break
        case "vaccination":
            cell.thirdRightLbl.isHidden = true
            cell.thirdLeftLbl.isHidden = true
            cell.frstLeftLbl.text = "Vacination"
            cell.frstRightLbl.text = shareVaccinationArr[indexPath.row].status
            cell.secondLeftLbl.text = "Date"
            cell.secondRightLbl.text = shareVaccinationArr[indexPath.row].date
            break
        case "medication":
            cell.frstLeftLbl.text = "Drug Name"
            cell.frstRightLbl.text = medArr[indexPath.row].drugName
            
            cell.secondLeftLbl.text = "Advice"
            cell.secondRightLbl.text = medArr[indexPath.row].advice
            
            cell.thirdLeftLbl.text = "Quantity"
            cell.thirdRightLbl.text = medArr[indexPath.row].quantity
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func getdata(url: String){
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            
            response in
            if response.result.isSuccess{
             
                let json: JSON = JSON(response.result.value!)
                print(json)
                
                if self.share == "careplan"{
                    for (_,j) in json{
                        self.careplanArr.append(SharePlan(fromJson: j))
                    }
                    print(self.careplanArr)
                }else if self.share == "vaccination"{
                    for (_,j) in json{
                        self.shareVaccinationArr.append(Vaccination(fromJson: j))
                    }
                }else if self.share == "medication"{
                    for (_,j) in json{
                        self.medArr.append(Medication(fromJson: j))
                    }
                }
               
                DispatchQueue.main.async {
                    self.shareTblVu.reloadData()
                }
                
            }else{
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        
        switch share {
        case "careplan":
            var careplanArray = [String]()
            
            for care in careplanArr{
               careplanArray.append(care.id)
            }
            print(careplanArray)
            AppointmentViewController.request.carePlan = careplanArray
            break
        case "vaccination":
           var vacArray = [String]()
            for vac in shareVaccinationArr{
                vacArray.append(vac.id)
            }
           print(vacArray)
           AppointmentViewController.request.vaccination = vacArray
            break
        case "medication":
            var medArray = [String]()
            for med in shareVaccinationArr{
                medArray.append(med.id)
            }
            print(medArray)
            AppointmentViewController.request.medication = medArray
            break
        default:
            dismiss(animated: true, completion: nil)
            break
            
        }
        dismiss(animated: true, completion: nil)
    }
   

}
