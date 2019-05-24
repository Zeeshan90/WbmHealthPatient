//
//  ConfirmAppointmentViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/22/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
class ConfirmAppointmentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var docSeeTblVu: UITableView!
    @IBOutlet weak var paymentVu: UIView!
    @IBOutlet weak var costVu: UIView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var emailTxtFld: TextField!
    @IBOutlet weak var confirmBtn: UIButton!
    let util = Utils()
    var docSeeArr = ["Share CarePlan","Vaccination","Share Medication","Share Observation"]
    override func viewDidLoad() {
        super.viewDidLoad()

        util.cardView(view: costVu)
        util.cardView(view: paymentVu)
        setValues()
        
        // Do any additional setup after loading the view.
    }
    
    func setValues(){
        let date = AppointmentViewController.request.apptDate
        let time = AppointmentViewController.request.apptTime
        dateLbl.text = "\(date!),\(time!)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docSeeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = docSeeTblVu.dequeueReusableCell(withIdentifier: "appoinmentcell", for: indexPath) as! ConfirmAppointmentTableViewCell
        cell.titleLbl.text = docSeeArr[indexPath.row]
        //cell.checkBox.addTarget(self, action: #selector(checkBox()), for: .valueChanged)
        return cell
    }
    
//    @objc func checkBox(){
//
//    }
    @IBAction func confirmBtn(_ sender: Any) {
        confirmAppointment()
    }
    
    func confirmAppointment(){
        
        if emailTxtFld.text != "" {
            let checkEmail = isValidEmail(emailID: emailTxtFld.text!)
            if checkEmail{
                AppointmentViewController.request.email = emailTxtFld.text!
                
                let url = "\(AppUtils.returnBaseUrl())/patient/my/appot/make"
                let params = AppointmentViewController.request.returnAppointReq()
                print(params)
                Alamofire.request(url, method: .post, parameters: params).responseJSON{
                    
                    response in
                    if response.result.isSuccess{
                        
                    }else{
                        print(response.error as Any)
                    }
                }
            }else{
                getAlert(message: "Enter valid Email", title: "Invalid")
            }
           
            
        }else{
            
            getAlert(message: "Enter email so we can send you the email to remind your appoinment", title: "Email")
        }
        
    }
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func getAlert(message:String?,title:String?){
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


