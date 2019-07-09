//
//  AppointmentViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/22/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class AppointmentViewController: UIViewController {

    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var reasonTxtFld: TextField!
    @IBOutlet weak var timeLbl: UILabel!
    static var request = AppointRequest()
    //let date = Date()
    let calender = Calendar.current
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDateTime()
        // Do any additional setup after loading the view.
    }
    

    func setDateTime(){
        
        let selectedDate = AppointmentViewController.request.apptDate
        let date = convertdate(date: selectedDate!)
        let day = calender.component(.weekday, from: date)
        let currentday = calender.shortWeekdaySymbols[day-1]
        let am = calender.amSymbol
        let pm = calender.pmSymbol
        
        let time = WbmDefaults.instance.getString(key: "time")
        let strArr = time.components(separatedBy: ".")
       
        let intMin = Int(strArr[1])
        var intHour = Int(strArr[0])
        var addMin = intMin! + 30
        
        if addMin == 60 {
            addMin = 00
            intHour = intHour! + 1
        }
        
        let endTime = "\(intHour!).\(addMin)"
        if time >= "12:00"{
            timeLbl.text = "Time \(time) to \(endTime) \(pm) On \(currentday)"
        }else{
            timeLbl.text = "Time \(time) to \(endTime) \(am) On \(currentday)"
        }
    }
    
    // Converting Date to string
    func convertdate(date: String) -> Date{
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let datee = dateFormatter.date(from: date)
        return datee!
    }
    
    
    @IBAction func continueBtn(_ sender: Any) {
        if reasonTxtFld.text != ""{
            AppointmentViewController.request.apptReason = reasonTxtFld.text
            performSegue(withIdentifier: "toconfirm", sender: self)
        }else{
                getAlert(message: "Enter some reason", title: "Enter Reason")
        }
        
    }
    func getAlert(message:String?,title:String?){
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}
