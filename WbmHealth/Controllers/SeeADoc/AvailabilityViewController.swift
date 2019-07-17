//
//  AvailabilityViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/16/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import GCCalendar
import SkeletonView
import Alamofire

class AvailabilityViewController: UIViewController,GCCalendarViewDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var avalibilityTblVu: UITableView!
    @IBOutlet weak var calender: GCCalendarView!
    var dateFormatter = DateFormatter()
    var intervalArr = [String]()
    var doubleArr = [String]()
    var dateStr: String!
    let date = Date()
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avalibilityTblVu.tableFooterView = UIView()
        avalibilityTblVu.showSkeleton()
        calender.delegate = self
        calender.displayMode = .month
        getIntervals()
        
        // Do any additional setup after loading the view.
    }
    
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date, inCalendar calendar: Calendar) {
        
        dateStr = convertdate(date: date)
        AppointmentViewController.request.apptDate = dateStr
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        navTitle.title = "\(calendar.monthSymbols[month-1]) \(year)"
        getIntervals()
    }
    
    // Converting Date to string
    func convertdate(date: Date) -> String{
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        return dateString
    }
    
    // Getting current Time
    func getTime(){
        
        doubleArr = [String]()
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print("\(hour):\(minutes)")
        let currentTime = "\(hour).\(minutes)"
        for i in intervalArr{
            print(i)
            doubleArr.append(i)
//            if i >= currentTime{
//
//            }
        }
        DispatchQueue.main.async {
            self.avalibilityTblVu.reloadData()
        }
    }
 

    func getIntervals(){
        
        intervalArr = [String]()
        let docId = WbmDefaults.instance.getString(key: "docId")
        let url = "\(AppUtils.returnBaseUrl())/patient/doctor/date/intervals/\(docId)"
        Alamofire.request(url, method: .post, parameters: ["date": "\(dateStr!)"]).responseJSON{
            response in
            self.avalibilityTblVu.hideSkeleton()
            if response.result.isSuccess{
               self.avalibilityTblVu.hideSkeleton()
                print(response.result.value as Any)
                self.intervalArr = response.result.value as! [String]
                self.getTime()
            }else{
                print(response.error as Any)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doubleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = avalibilityTblVu.dequeueReusableCell(withIdentifier: "availablecell", for: indexPath) as! AvailabilityTableViewCell
        cell.timeLbl.text = doubleArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = self.avalibilityTblVu.cellForRow(at: indexPath) as! AvailabilityTableViewCell
        let selectedCell = currentCell.timeLbl.text
        AppointmentViewController.request.apptTime = selectedCell
        WbmDefaults.instance.setString(key: "time", value: selectedCell!)
        performSegue(withIdentifier: "toavailabilty", sender: self)
        self.avalibilityTblVu.deselectRow(at: indexPath, animated: true)
    }

}

