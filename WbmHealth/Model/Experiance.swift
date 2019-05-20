//
//  Experiance.swift
//  WbmHealth
//
//  Created by WBM on 5/20/19.
//  Copyright © 2019 WBM. All rights reserved.
//
import Foundation
import SwiftyJSON

class ExperienceDetail : NSObject, NSCoding{
    
    var id : String!
    var dateJoin : String!
    var dateLeave : String!
    var position : String!
    var workPlace : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        dateJoin = json["date_join"].stringValue
        dateLeave = json["date_leave"].stringValue
        position = json["position"].stringValue
        workPlace = json["work_place"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["_id"] = id
        }
        if dateJoin != nil{
            dictionary["date_join"] = dateJoin
        }
        if dateLeave != nil{
            dictionary["date_leave"] = dateLeave
        }
        if position != nil{
            dictionary["position"] = position
        }
        if workPlace != nil{
            dictionary["work_place"] = workPlace
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "_id") as? String
        dateJoin = aDecoder.decodeObject(forKey: "date_join") as? String
        dateLeave = aDecoder.decodeObject(forKey: "date_leave") as? String
        position = aDecoder.decodeObject(forKey: "position") as? String
        workPlace = aDecoder.decodeObject(forKey: "work_place") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if dateJoin != nil{
            aCoder.encode(dateJoin, forKey: "date_join")
        }
        if dateLeave != nil{
            aCoder.encode(dateLeave, forKey: "date_leave")
        }
        if position != nil{
            aCoder.encode(position, forKey: "position")
        }
        if workPlace != nil{
            aCoder.encode(workPlace, forKey: "work_place")
        }
        
    }
    
}
