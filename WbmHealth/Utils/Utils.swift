//
//  Utils.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import UIKit

class Utils: NSObject {
    
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
    
    // Alert
    class func showAlert(view: UIViewController , message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
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
    
    class func setSearchBar(controller: UIViewController){
        
        var searchController = UISearchController()
        searchController = UISearchController(searchResultsController: nil)
        //searchController.searchResultsUpdater = self
        controller.navigationItem.searchController = searchController
        controller.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
}
