//
//  Qualification.swift
//  WbmHealth
//
//  Created by WBM on 5/20/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON


class Qualification : NSObject, NSCoding{
    
    var id : String!
    var institute : String!
    var passedDate : String!
    var qualificationName : String!
    var qualificationSpeciality : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        institute = json["institute"].stringValue
        passedDate = json["passed_date"].stringValue
        qualificationName = json["qualification_name"].stringValue
        let qualificationSpecialityJson = json["qualification_speciality"]
        if !qualificationSpecialityJson.isEmpty{
            qualificationSpeciality = qualificationSpecialityJson["speciality_name"].stringValue
        }
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
        if institute != nil{
            dictionary["institute"] = institute
        }
        if passedDate != nil{
            dictionary["passed_date"] = passedDate
        }
        if qualificationName != nil{
            dictionary["qualification_name"] = qualificationName
        }
//        if qualificationSpeciality != nil{
//            dictionary["qualificationSpeciality"] = qualificationSpeciality.toDictionary()
//        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "_id") as? String
        institute = aDecoder.decodeObject(forKey: "institute") as? String
        passedDate = aDecoder.decodeObject(forKey: "passed_date") as? String
        qualificationName = aDecoder.decodeObject(forKey: "qualification_name") as? String
//        qualificationSpeciality = aDecoder.decodeObject(forKey: "qualification_speciality") as? QualificationSpeciality
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
        if institute != nil{
            aCoder.encode(institute, forKey: "institute")
        }
        if passedDate != nil{
            aCoder.encode(passedDate, forKey: "passed_date")
        }
        if qualificationName != nil{
            aCoder.encode(qualificationName, forKey: "qualification_name")
        }
//        if qualificationSpeciality != nil{
//            aCoder.encode(qualificationSpeciality, forKey: "qualification_speciality")
//        }
        
    }
    
}
