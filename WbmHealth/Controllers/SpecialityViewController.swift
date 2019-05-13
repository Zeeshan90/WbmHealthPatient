//
//  SpecialityViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/9/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SpecialityViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var specialityArr = [Speciality]()
    
    @IBOutlet weak var specialityTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getSpeciality()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialityArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = specialityTblVu.dequeueReusableCell(withIdentifier: "specialitycell", for: indexPath) as! SpecialityTableViewCell
        cell.titleLbl.text = specialityArr[indexPath.row].specialityDesc
        cell.img.downloaded(from: "\(AppUtils.returnBaseUrl())\(specialityArr[indexPath.row].photo[indexPath.row])")
        return cell
    }
    
    
    func getSpeciality(){
        specialityArr = [Speciality]()
        let url = "\(AppUtils.returnBaseUrl())/patient/init/specialities"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            if response.result.isSuccess{
               
                let json = JSON(response.result.value!)
                let dataJson = json["data"]
                print(dataJson)
                
                for (_,j) in dataJson{
                    do {
                        let special = Speciality(fromJson: j)
                        self.specialityArr.append(special)
                    }
                }
                
                DispatchQueue.main.async {
                    self.specialityTblVu.reloadData()
                }
            }else
            {
                print(response.error as Any)
            }
        }
    }
}