//
//  LabTestDetailViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD
class LabTestDetailViewController: UIViewController {

    @IBOutlet weak var requirementVu: UIView!
    @IBOutlet weak var detailVu: UIView!
    @IBOutlet weak var bgrVu: UIView!
    @IBOutlet weak var addTestBtn: UIButton!
    @IBOutlet weak var testNameVu: UIView!
    
    @IBOutlet weak var reqDescriptionLbl: UILabel!
    @IBOutlet weak var sampleLbl: UILabel!
    @IBOutlet weak var reportingDayLbl: UILabel!
    @IBOutlet weak var performLbl: UILabel!
    @IBOutlet weak var testDescriptionLbl: UILabel!
    @IBOutlet weak var discountRateLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var testName: UILabel!
    @IBOutlet weak var testImg: UIImageView!
    let util = Utils()
    var labDetailArr = [LabDetail]()
    let labTestId = WbmDefaults.instance.getString(key: "labId")
    let index = WbmDefaults.instance.getInt(key: "index")
    override func viewDidLoad() {
        super.viewDidLoad()

        ProgressHUD.show("loading...")
        getTestDetails()
        Utils.cardView(view: detailVu)
        Utils.cardView(view: bgrVu)
        Utils.cardView(view: requirementVu)
        testNameVu.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addTestBtn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "tomain", sender: self)
    }
    
    func getTestDetails(){
        labDetailArr = [LabDetail]()
        let url = "\(AppUtils.returnBaseUrl())/patient/lab/labtests/\(labTestId)"
        Alamofire.request(url, method: .post, parameters: ["aIndex": "\(index)"]).responseJSON{
            response in
             ProgressHUD.dismiss()
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value!)
                print(json)
                do{
                    let td = LabDetail(fromJson: json)
                    self.labDetailArr.append(td) // td testDetail
                }
                
                DispatchQueue.main.async {
                    self.setDetails()
                }
            }else {
                Utils.showAlert(view: self, message: (response.error?.localizedDescription)!, title: "Error")
                
            }

            
            }
        }
    
    
    func setDetails(){
        
        for i in labDetailArr{
            
            let labtest = i.tests
            
            rateLbl.text = "Rate: " + String(i.rate)
            discountRateLbl.text = "Discount Rate: \(String(i.discount))"
            testDescriptionLbl.text = "Description: \(i.descriptionField ?? "No Description Available")"
            
            testName.text = labtest?.testName
            performLbl.text = "Performed: \(labtest?.performed ?? "Consult Doctor")"
            reportingDayLbl.text = "Reporting Day: \(labtest?.reportingDay ?? "Not Defined")"
            sampleLbl.text = "Sample: \(labtest?.sampleRequired ?? "Not Required")"
            let imgUrl = "\(AppUtils.returnBaseUrl())/\(labtest?.image ?? "v")".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                testImg.downloaded(from: imgUrl!)
               
            
        }
        
        
    }
}
