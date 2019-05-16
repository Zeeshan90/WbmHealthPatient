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

class AvailabilityViewController: UIViewController,GCCalendarViewDelegate {

    @IBOutlet weak var avalibilityTblVu: UITableView!
    @IBOutlet weak var calender: GCCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avalibilityTblVu.showSkeleton()
        calender.delegate = self
        calender.displayMode = .month
        
        // Do any additional setup after loading the view.
    }
    
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date, inCalendar calendar: Calendar) {
        
        print(calendar.monthSymbols)
        print(date)
        print(calendar.amSymbol)
        
    }
   


}

extension AvailabilityViewController: SkeletonTableViewDelegate,SkeletonTableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = avalibilityTblVu.dequeueReusableCell(withIdentifier: "availablecell", for: indexPath) as! AvailabilityTableViewCell
        
        return cell
    }
    
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        let cell = avalibilityTblVu.dequeueReusableCell(withIdentifier: "availablecell")
        return (cell?.reuseIdentifier)!
    }

}
