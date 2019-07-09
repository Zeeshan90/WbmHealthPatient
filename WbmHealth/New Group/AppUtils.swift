//
//  AppUtils.swift
//  WbmHealth
//
//  Created by WBM on 4/26/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftToast
import CoreData
import SwiftyJSON

class AppUtils{
    
    static let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    static let app = (UIApplication.shared.delegate as! AppDelegate )
    static var sharedInstance = AppUtils()
    
    static func returnBaseUrl() ->String{
        
        //return "http://192.168.1.16:3031"
        return "https://wbmchat.com"
        //return "http://192.168.1.185:3031"
         //return "http://192.168.1.53:3031"
       
    }
    
    static func returnLocalBaseUrl() ->String{
         return "http://192.168.1.185:3031"
        
    }
    
    
    static func returnSideMenu () -> [SideMenu]{
        
        var mainMenu = [SideMenu]()
        
        let menu1 = SideMenu()
        menu1.name = "Home"
        menu1.image = "home"
        mainMenu.append(menu1)
        
        let menu2 = SideMenu()
        menu2.name = "Appoinments"
        menu2.image = "appoinment"
        mainMenu.append(menu2)
        
        let menu3 = SideMenu()
        menu3.name = "Profile Setting"
        menu3.image = "profile"
        mainMenu.append(menu3)
        
        let menu4 = SideMenu()
        menu4.name = "Contact Us"
        menu4.image = "contactus"
        mainMenu.append(menu4)
        
        let menu5 = SideMenu()
        menu5.name = "About Us"
        menu5.image = "contactus"
        mainMenu.append(menu5)
        
        let menu6 = SideMenu()
        menu6.name = "WBM Health Service"
        menu6.image = "health"
        mainMenu.append(menu6)
        
        let menu7 = SideMenu()
        menu7.name = "Privacy Policy"
        menu7.image = "privacypolicy"
        mainMenu.append(menu7)
        
        let menu8 = SideMenu()
        menu8.name = "Logout"
        menu8.image = "12"
        mainMenu.append(menu8)
        
        let menu9 = SideMenu()
        menu9.name = "Share"
        menu9.image = "share"
        mainMenu.append(menu9)
        
        
        return mainMenu
    }
    
    static func returnBase64Image(image: UIImage) -> String {
        let imageData:NSData = image.pngData()! as NSData
        let imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        print(imageStr)
        return imageStr
    }
    
    static func returnBase64Image(imageData : Data) -> String {
        
        let imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        print(imageStr)
        return imageStr
    }
    
    static func returnErrorToast(string : String) -> SwiftToast {
        return SwiftToast(
            text: string,
            textAlignment: .center,
            image: UIImage(named: "icAlert"),
            backgroundColor: UIColor.darkGray,
            textColor: .white,
            font: .boldSystemFont(ofSize: 15.0),
            duration: 1.0,
            minimumHeight: CGFloat(100.0),
            statusBarStyle: .lightContent,
            aboveStatusBar: true,
            target: nil,
            style: .navigationBar)
    }


    static func returnToast(string : String) -> SwiftToast {
        return SwiftToast(
            text: string,
            textAlignment: .center,
            image: UIImage(named: "done"),
            backgroundColor: UIColor.white,
            textColor: UIColor.green,
            font: .boldSystemFont(ofSize: 15.0),
            duration: 1.0,
            minimumHeight: CGFloat(100.0),
            statusBarStyle: .lightContent,
            aboveStatusBar: true,
            target: nil,
            style: .navigationBar)
    }
    
    static func toast(string: String) -> SwiftToast{
        return SwiftToast(text: string, textAlignment: NSTextAlignment.center, image: nil, backgroundColor: UIColor.white, textColor: UIColor.black, font: nil, duration: 1.2, minimumHeight: CGFloat(100.0), statusBarStyle: UIStatusBarStyle.lightContent, aboveStatusBar: false, isUserInteractionEnabled: false, target: nil, style: SwiftToastStyle.bottomToTop)
    }
    
    // Delete All entries in the Coredata Entry
    static  func deleteEntityAllData(entity : String) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do{
            let result = try AppUtils.context.execute(request)
        }
        catch{
            print(error)
        }
         
        
    }

//    static func parseUser(json : JSON) -> User{
//        var user = User(context: AppUtils.context)
//        if json != nil{
//            user.token = json["token"].string!
//            
//            user.name = json["user"]["name"].string!
//            user.email = json["user"]["email"].string!
//            user.mobile = json["user"]["mobile"].string!
//            user.password = json["user"]["password"].string!
//            user.id = json["user"]["_id"].string!
//            //WbmDefaults.instance.setString(key: "token", value: user.token!)
//            do{
//                //user.image = json["user"]["image"].string!
//                //WbmDefaults.instance.setString(key: "img", value: json["user"]["image"].string!)
//            }catch{
//                
//            }
//            
//        }
//        return user;
//    }
    
    // Save Changes in the core data
    static func saveChanges()  {
        do{
            try self.context.save()
        }
        catch{
            print("some error to save this")
        }
    }
    
    
    func savetoCart(object: [String:Any]){
        
        let cart = NSEntityDescription.insertNewObject(forEntityName: "LabTests", into: AppUtils.context) as! LabTests
        cart.id = object["id"] as? String
        cart.discount = object["discount"] as? String
        cart.testName = object["testName"] as? String
        cart.imgUrl = object["imgUrl"] as? String
        cart.price = object["price"] as? String
        cart.testCode = object["testCode"] as? String
        
        do {
            try AppUtils.context.save()
        } catch  {
            print("Data not Saved")
        }
    }
    
    func getAllCartProducts() -> [LabTests]{
        var cart = [LabTests]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LabTests")
        do{
            cart = try AppUtils.context.fetch(fetchRequest) as! [LabTests]
        }catch{
            print("Error to fetch")
        }
        return cart
    }
    
    func deleteCartProduct(index: Int) -> [LabTests]{
        var cart = getAllCartProducts()
        AppUtils.context.delete(cart[index])
        cart.remove(at: index)
        do {
            try AppUtils.saveChanges()
        } catch  {
            print(error.localizedDescription)
        }
        return cart
    }
    
    func saveUser(object: [String:Any]){
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "Users", into: AppUtils.context) as! Users
      
        
        do {
            try AppUtils.context.save()
        } catch  {
            print("Data not Saved")
        }
    }
}


