//
//  Utils.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
class Utils: UIViewController,NVActivityIndicatorViewable {
    
    static let userId: String = WbmDefaults.instance.getString(key: "userId")
    static let userName: String = WbmDefaults.instance.getString(key: "userName")
    let dateFormatter = DateFormatter()
    static var instance = Utils()
    /// CardView
    class func cardView(view:UIView){
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
    
    // Set Search Bar in the Navigation Bar
    class func setSearchBar(controller: UIViewController,updater: UISearchResultsUpdating){
        
        var searchController = UISearchController()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = updater
        controller.navigationItem.searchController = searchController
        controller.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchController.isActive = true
    }
    
    // Check Email is Valid or not
    class func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    // Check Email is Valid or not
    class func isValidSsnId(ssnId:String) -> Bool {
        let ssnid = "(^[0-9/+]{5}-[0-9/+]{7}-[0-9]{1}$)|(^\\-{3}-\\-{2}-\\-{4}$)"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", ssnid)
        return emailTest.evaluate(with: ssnId)
    }
    
//    func phoneNumberValidation(value: String) -> Bool {
//        var charcter  = NSCharacterSet(charactersIn: "01234567890").inverted
//        var filtered:NSString!
//        var inputString:NSArray = value.components(separatedBy: charcter) as NSArray
//        filtered = inputString.componentsJoined(by: "") as NSString
//        return  value == filtered
//    }
//
    
    
     func indicatorsTypes(i:Int) -> NVActivityIndicatorType {
        return NVActivityIndicatorType.allCases[i]
    }
    
     func startIndicator(type:Int) {
        let indicatorType = indicatorsTypes(i: type)
        let size = CGSize(width: 50, height: 50)
        self.startAnimating(size, message: "Please wait...", type: indicatorType, fadeInAnimation: nil)
    }
    
}
