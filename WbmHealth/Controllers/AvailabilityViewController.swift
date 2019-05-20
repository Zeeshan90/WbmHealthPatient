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
class AvailabilityViewController: UIViewController,GCCalendarViewDelegate {

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var avalibilityTblVu: UITableView!
    @IBOutlet weak var calender: GCCalendarView!
    var dateFormatter = DateFormatter()
    var intervalArr = [String]()
    var dateStr: String!
    let date = Date()
    let calendar = Calendar.current
    override func viewDidLoad() {
        super.viewDidLoad()

        avalibilityTblVu.showSkeleton()
        calender.delegate = self
        calender.displayMode = .month
        getIntervals()
       
        
       
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date, inCalendar calendar: Calendar) {
        
        dateStr = convertdate(date: date)
        let month = calendar.component(.month, from: date)
        navTitle.title = calendar.monthSymbols[month-1]
        getTime()
//        print(date)
//        currentDate = date
//        date.mon
//        print(calendar.amSymbol)
        
        
        
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
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print("\(hour):\(minutes)")
        let currentTime = "\(hour):\(minutes)"
        
    }
 

    func getIntervals(){
        
        let docId = WbmDefaults.instance.getString(key: "docId")
        let url = "\(AppUtils.returnBaseUrl())/patient/date/intervals/\(docId)"
        Alamofire.request(url, method: .post, parameters: ["date": "\(dateStr!)"]).responseJSON{
            response in
            
            self.avalibilityTblVu.hideSkeleton()
            if response.result.isSuccess{
                print(response.result.value as Any)
                self.intervalArr = response.result.value as! [String]
                self.avalibilityTblVu.reloadData()
            }else{
                print(response.error as Any)
            }
            
        }
    }

}

extension AvailabilityViewController: SkeletonTableViewDelegate,SkeletonTableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intervalArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = avalibilityTblVu.dequeueReusableCell(withIdentifier: "availablecell", for: indexPath) as! AvailabilityTableViewCell
        cell.timeLbl.text = intervalArr[indexPath.row]
        return cell
    }
    
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return intervalArr.count
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "availablecell"
    }

}
