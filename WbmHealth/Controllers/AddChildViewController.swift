//
//  AddChildViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/9/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import PickerView
class AddChildViewController: UIViewController,PickerViewDelegate,PickerViewDataSource {
   
    @IBOutlet weak var donebtn: UIButton!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var pickerHideVu: UIView!
    @IBOutlet weak var pickerVu: PickerView!
    @IBOutlet weak var fNameTxtFld: UITextField!
    @IBOutlet weak var lNameTxtFld: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var dobBtn: UIButton!
    var genderArr = ["Male","Female"]
    override func viewDidLoad() {
        super.viewDidLoad()
        genderBtn.setTitle(genderArr[0], for: .normal)
        pickerVu.delegate = self
        pickerVu.dataSource = self
        
    }
    
    
    @IBAction func genderBtn(_ sender: Any) {
        pickerVu.isHidden = false
        pickerHideVu.isHidden = false
        datepicker.isHidden = true
        donebtn.isHidden = false
    }
    
    @IBAction func dobBtn(_ sender: Any) {
       datepicker.isHidden = false
        pickerHideVu.isHidden = false
        pickerVu.isHidden = true
        donebtn.isHidden = true
    }
    @IBAction func saveBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        return genderArr.count
    }
    
    func pickerView(_ pickerView: PickerView, titleForRow row: Int) -> String {
        return genderArr[row]
    }
    
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 50
    }
    func pickerView(_ pickerView: PickerView, didSelectRow row: Int) {
        genderBtn.setTitle(genderArr[row], for: .normal)
    }
    
    func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
        label.textAlignment = .center
        
        if highlighted {
            label.font = UIFont.systemFont(ofSize: 25.0)
            label.textColor = #colorLiteral(red: 0.005218341481, green: 0.30667454, blue: 0.4687452316, alpha: 1)
        } else {
            label.font = UIFont.systemFont(ofSize: 15.0)
            label.textColor = .lightGray
        }
    }
    @IBAction func pickerDoneBtn(_ sender: Any) {
        pickerVu.isHidden = true
        pickerHideVu.isHidden = true
        datepicker.isHidden = true
        donebtn.isHidden = true
    }
}
