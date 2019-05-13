//
//  LabCategoryViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class LabCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var labCatArr = [LabCategory]()
    
    @IBOutlet weak var labCatTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        ProgressHUD.spinnerColor(#colorLiteral(red: 0.005218341481, green: 0.30667454, blue: 0.4687452316, alpha: 1))
        getLabCat()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labCatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = labCatTblVu.dequeueReusableCell(withIdentifier: "labcatcell", for: indexPath) as! LabCategoryTableViewCell
        cell.nameLbl.text = labCatArr[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "testdetail", sender: self)
    }
    
    
    func getLabCat(){
        
        labCatArr = [LabCategory]()
        let url = "\(AppUtils.returnBaseUrl())/patient/init/labtestscat"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
        response in
            
            if response.result.isSuccess{
                let json = JSON(response.result.value!)
                let valueJson = json["result"]
                print(valueJson)
                ProgressHUD.dismiss()
                for (_,j) in valueJson{
                    do {
                        let labJson = LabCategory.init(fromJson: j)
                        self.labCatArr.append(labJson)
                    }
                }
                
                DispatchQueue.main.async {
                    self.labCatTblVu.reloadData()
                }
            }
        }
       
        
    }

}
