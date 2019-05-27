//
//  AppointAprovedViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/2/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AppointAprovedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    var appointArr = [ConfirmAppoint]()
    @IBOutlet weak var aprrovedAppointTblVu: UITableView!
    let card = Utils()
    override func viewDidLoad() {
        super.viewDidLoad()
        getAppointments()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = aprrovedAppointTblVu.dequeueReusableCell(withIdentifier: "appointcell", for: indexPath) as! ConfirmAppointTableViewCell
        cell.nameLbl.text = "WBM Health"
        cell.descriptionLbl.text = "we have booked ahsan ayub doctor for your checkup"
        card.cardView(view: cell.Vu)
        return cell
    }

    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func getAppointments(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/appoinment/status/accepted/all/5c94754e0948dd2edcb4c299"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                print(json)
                
                for (_,j) in json{
                    do {
                        let appointjson = ConfirmAppoint(fromJson: j)
                        self.appointArr.append(appointjson)
                    }
                }
                
            }else{
                print(response.error?.localizedDescription as Any)
            }
        }
    }
}
