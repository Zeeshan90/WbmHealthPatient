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
    override func viewDidLoad() {
        super.viewDidLoad()

        let labtest = "5c179b836c66fb2d8cdb2b55"
        let labcat = "5c99dd8c542d3240fe961967"
        //getTestDetail(testId: labtest, testCatId: labcat)
        getTestDetails(testId: labtest)
        util.cardView(view: detailVu)
        util.cardView(view: bgrVu)
        util.cardView(view: requirementVu)
        testNameVu.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addTestBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func getTestDetails(testId: String){
        let url = "\(AppUtils.returnBaseUrl())/patient/lab/labtests/\(testId)"
        Alamofire.request(url, method: .post, parameters: ["aIndex": "0"]).responseJSON{
            response in
            
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value!)
                print(json)
                do{
                    let td = LabDetail(fromJson: json)
                    self.labDetailArr.append(td)
                }
                
                DispatchQueue.main.async {
                    self.setDetails()
                }
            }else {
                print(response.error as Any)
            }

            
            }
        }
    
    func getTestDetail(testId:String,testCatId:String){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/lab/labtests/all/\(testId)/\(testCatId)"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value!)
                print(json)
                
                for (_,j) in json{
                    do{
                        let td = LabDetail(fromJson: j)
                        self.labDetailArr.append(td)
                    }
                }
                
                DispatchQueue.main.async {
                   self.setDetails()
                }
            }
        }
    }
    
    
    func setDetails(){
        
        for i in labDetailArr{
            let labtest = i.tests
            let testDetailImg = labtest?.photo
            
            rateLbl.text = "Rate: \(String(i.rate))"
            discountRateLbl.text = "Discount Rate: \(String(i.discount))"
            testDescriptionLbl.text = "Description: \(i.descriptionField ?? "No Description Available")"
            
            testName.text = labtest?.testName
            performLbl.text = "Performed: \(labtest?.performed ?? "Consult Doctor")"
            reportingDayLbl.text = "Reporting Day: \(labtest?.reportingDay ?? "Not Defined")"
            sampleLbl.text = "Sample: \(labtest?.sampleRequired ?? "Not Required")"
           
            //testImg.downloaded(from:"http://192.168.1.185:3031/labTests/17-OHProgesterone1556197886988.png")
            for img in testDetailImg!{

                let imgUrl = "\(AppUtils.returnBaseUrl())/\(img.url!)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                testImg.downloaded(from: imgUrl!)
               
            }
        }
        
        
    }
}
