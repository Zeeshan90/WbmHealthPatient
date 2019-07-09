//
//  User.swift
//  WbmHealth
//
//  Created by Zeeshan on 02/07/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON
class User{
    
    
    var v : Int!
    var id : String!
    var account : [AnyObject]!
//    var address : [AnyObject]!
    var appointment : [AnyObject]!
    var birthDate : String!
    var bloodGroup : String!
    var bloodPressure : [Int]!
    var carePlan : [AnyObject]!
    var condition : [AnyObject]!
    var cpStatus : Bool!
    var createdAt : String!
    var disSummary : [AnyObject]!
    var expireAt : String!
    var family : [AnyObject]!
    var gender : String!
    var heartRate : Int!
    var height : Int!
    var history : [AnyObject]!
    var intake : [AnyObject]!
    var maritalStatus : String!
    var medication : [AnyObject]!
    var medStatus : Bool!
    
    var notes : [AnyObject]!
    var observation : [AnyObject]!
    var obsStatus : Bool!
    var otherInformation : [AnyObject]!
    var output : [AnyObject]!
    var password : String!
    
    var procedure : [AnyObject]!
    var resourceId : String!
    var roomTransfer : [AnyObject]!
    var ssn : String!
    var telecom : [AnyObject]!
    var temperature : [AnyObject]!
    var token : String!
    var vaccination : [AnyObject]!
    var vacStatus : Bool!
    var vitalSigns : [AnyObject]!
    var weight : Int!
    
    var address: Address!
    var given : [AnyObject]!
    var suffix : [AnyObject]!
    var name : String!
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        v = json["__v"].intValue
        id = json["_id"].stringValue
        
        address = Address(addressjson: json["address"])
        account = [AnyObject]()
        let accountArray = json["account"].arrayValue
        for accountJson in accountArray{
            
        }
        
        appointment = [AnyObject]()
        let appointmentArray = json["appointment"].arrayValue
        for appointmentJson in appointmentArray{
            
        }
        birthDate = json["birthDate"].stringValue
        bloodGroup = json["bloodGroup"].stringValue
        
        let bloodPressureArray = json["bloodPressure"].arrayValue
        for bloodPressureJson in bloodPressureArray{
           
        }
        
       
        let carePlanArray = json["carePlan"].arrayValue
        for carePlanJson in carePlanArray{
            
        }
        
        
        let conditionArray = json["condition"].arrayValue
        for conditionJson in conditionArray{
            
        }
        cpStatus = json["cpStatus"].boolValue
        createdAt = json["createdAt"].stringValue
        expireAt = json["expireAt"].stringValue
        
        
        let familyArray = json["family"].arrayValue
        for familyJson in familyArray{

        }
        gender = json["gender"].stringValue
        heartRate = json["heartRate"].intValue
        height = json["height"].intValue
    
        let historyArray = json["history"].arrayValue
        for historyJson in historyArray{
         
        }
       
        maritalStatus = json["maritalStatus"].stringValue
        
        let medicationArray = json["medication"].arrayValue
        for medicationJson in medicationArray{
           
        }
        medStatus = json["medStatus"].boolValue
       
        let nameArray = json["name"].arrayValue
        for nameJson in nameArray{
            name = nameJson["text"].stringValue
        }
        
    
        obsStatus = json["obsStatus"].boolValue
       
        password = json["password"].stringValue
        resourceId = json["resourceId"].stringValue
        ssn = json["ssn"].stringValue
        token = json["token"].stringValue
        vacStatus = json["vacStatus"].boolValue
        weight = json["weight"].intValue
    }
}

class Address{
    
    init(addressjson: JSON!){
        
    }
}
