//
//  Utils.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    let dateFormatter = DateFormatter()
    
    /// CardView
    func cardView(view:UIView){
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1
        view.layer.cornerRadius = 10
    }
    
    // Converting a Short Date to string
    func convertShortDate(date: Date) -> String{
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        return dateString
    }
    
    // Converting A Short String to Date
    func convertShortString(date: String) -> Date{
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let datee = dateFormatter.date(from: date)
        print(datee!)
        return datee!
    }
    
    // Converting A Long String to Date
    func convertLongString(date: String) -> Date{
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let datee = dateFormatter.date(from: date)
        print(datee!)
        return datee!
    }
    
    // Converting a Long Date to String
    func convertlongDate(date: Date) -> String{
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        return dateString
    }
}
