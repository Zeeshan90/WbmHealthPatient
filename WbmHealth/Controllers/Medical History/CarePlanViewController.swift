//
//  CarePlanViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/7/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CarePlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var carePlanTblVu: UITableView!
    var share: String = ""
    var careArr = [SharePlan]()
    var vacArr = [Vaccination]()
    var medArr = [Medication]()
    
    var util = Utils()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getdata(url: "\(AppUtils.returnBaseUrl())/patient/get/" + share + "/" + Utils.userId)
        switch share {
        case "careplan":
            
            self.navigationItem.title = "Care Plan"
        case "vaccination":
           
            self.navigationItem.title = "Vaccination"
        case "medication":
        
            self.navigationItem.title = "Medication"
        default:
            break
            
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch share {
        case "careplan":
            return careArr.count
            
        case "vaccination":
            return vacArr.count
            
        case "medication":
            return medArr.count
            
        default:
            return 0
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = carePlanTblVu.dequeueReusableCell(withIdentifier: "careplancell", for: indexPath) as! CarePlanTableViewCell
        Utils.cardView(view: cell.vu)
        
        switch share {
        case "careplan":
           cell.frstLeftVu.text = "Category"
           cell.frstRightVu.text = careArr[indexPath.row].text
           
           cell.secondLeftVu.text = "Status"
           cell.secondRightVu.text = careArr[indexPath.row].status
           
           cell.thirdLeftVu.text = "Reason"
           cell.thirdRightVu.text = careArr[indexPath.row].statusReason.text
           
           cell.forthLeftVu.text = "Period"
           cell.forthRightVu.text = careArr[indexPath.row].period.start + careArr[indexPath.row].period.end
            break
        case "vaccination":
            cell.frstLeftVu.text = "Type"
            cell.frstRightVu.text = vacArr[indexPath.row].type
            
            cell.secondLeftVu.text = "Status"
            cell.secondRightVu.text = vacArr[indexPath.row].status
            
            cell.thirdLeftVu.text = "Date"
          //  let strDate = util.convertShortString(date: vacArr[indexPath.row].date)
            cell.thirdRightVu.text = vacArr[indexPath.row].date
            break
        case "medication":
            cell.frstLeftVu.text = "Category"
            cell.frstRightVu.text = medArr[indexPath.row].category
            
            cell.secondLeftVu.text = "Drug Name"
            cell.secondRightVu.text = medArr[indexPath.row].drugName
            
            cell.thirdLeftVu.text = "Quantity"
            cell.thirdRightVu.text = medArr[indexPath.row].quantity
            break
        default:
            break
        }
        
        return cell
    }
    
    func getdata(url: String){
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            
            response in
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                print(json)
                
                if self.share == "careplan"{
                    for (_,j) in json{
                        self.careArr.append(SharePlan(fromJson: j))
                    }
                    //print(self.careplanArr)
                }else if self.share == "vaccination"{
                    for (_,j) in json{
                        self.vacArr.append(Vaccination(fromJson: j))
                    }
                }else if self.share == "medication"{
                    for (_,j) in json{
                        self.medArr.append(Medication(fromJson: j))
                    }
                }
                
                DispatchQueue.main.async {
                    self.carePlanTblVu.reloadData()
                }
                
            }else{
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
}
