//
//  AddChildViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/9/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import PickerView
import McPicker
import SwiftyJSON
import ProgressHUD
import Alamofire
class AddChildViewController: UIViewController {
   
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var fNameTxtFld: UITextField!
    @IBOutlet weak var lNameTxtFld: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var dobBtn: UIButton!
    var genderArr = ["Male","Female"]
    var util = Utils()
    override func viewDidLoad() {
        super.viewDidLoad()
        genderBtn.setTitle(genderArr[0], for: .normal)
        datepicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewtaped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func viewtaped(gestureRecognizer: UITapGestureRecognizer){
        datepicker.isHidden = true
    }
    @objc func dateChanged(datePicker: UIDatePicker){
        let stringDate = util.convertShortDate(date: datepicker.date)
        dobBtn.setTitle(stringDate, for: .normal)
    }
    @IBAction func genderBtn(_ sender: Any) {
        datepicker.isHidden = true
        McPicker.show(data: [genderArr]) {  [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                self!.genderBtn.setTitle(name, for: .normal)
            }
        }
    }
    
    @IBAction func dobBtn(_ sender: Any) {
        datepicker.isHidden = false
    }
    @IBAction func saveBtn(_ sender: Any) {
        datepicker.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func addChild(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/family/add/" + Utils.userId
        Alamofire.request(url, method: .put, parameters: nil).responseJSON{
            
            response in
            ProgressHUD.dismiss()
            if response.result.isSuccess{
                let json: JSON = JSON(response.result.value!)
            }else{
                
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
}
