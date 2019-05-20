//
//  DocBio.swift
//  WbmHealth
//
//  Created by WBM on 5/17/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON


class DocBio{
    
    var v : Int!
    var id : String!
    var aboutme : String!
    //var address : [Addres]!
    //var availability : [Availability]!
    var birthDay : String!
    //var contacts : [AnyObject]!
    var doctorName : String!
    var doctorSpeciality : String!
   
    var qualifications : [Qualification]!
    
    var experianceArr: [ExperienceDetail]!
    var gender : String!
   // var hospitals : AnyObject!
    var intervals : [String]!
    var language : [String]!
    var maxfee : String!
    var minfee : String!
    var photo : String!
    
    //var reviews : [Review]!
//    var ssn : String!
//    var sts : String!
    //var telecom : [Telecom]!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        v = json["__v"].intValue
        id = json["_id"].stringValue
        aboutme = json["aboutme"].stringValue
//        address = [Addres]()
//        let addressArray = json["address"].arrayValue
//        for addressJson in addressArray{
//            let value = Addres(fromJson: custArrayJson)
//            custArray.append(value)
//        }
//        availability = [Availability]()
//        let availabilityArray = json["availability"].arrayValue
//        for availabilityJson in availabilityArray{
//            let value = Availability(fromJson: custArrayJson)
//            custArray.append(value)
//        }
        birthDay = json["birthDay"].stringValue
//        contacts = [Int]()
//        let contactsArray = json["contacts"].arrayValue
//        for contactsJson in contactsArray{
//            contacts.append(contactsJson.)
//        }
        let doctorNameJson = json["doctor_name"]
        let givenArray = doctorNameJson["given"].arrayValue
        doctorName = "\(givenArray[0]) \(givenArray[2])"
        
        doctorSpeciality = json["doctor_speciality"].stringValue
        
        experianceArr = [ExperienceDetail]()
        let experienceJson = json["experience"]
        let expDetail = experienceJson["experience_details"].arrayValue
        for exp in expDetail{
            let value = ExperienceDetail(fromJson: exp)
            experianceArr.append(value)
        }
        gender = json["gender"].stringValue
        
        //hospitals = json["hospitals"]
        
        intervals = [String]()
        let intervalsArray = json["intervals"].arrayValue
        for intervalsJson in intervalsArray{
            intervals.append(intervalsJson.stringValue)
        }
        
        language = [String]()
        let languageArray = json["language"].arrayValue
        for languageJson in languageArray{
            language.append(languageJson.stringValue)
        }
        maxfee = json["maxfee"].stringValue
        minfee = json["minfee"].stringValue
        
        
        
        let photoArray = json["photo"].arrayValue
        for photoJson in photoArray{
            photo = photoJson["url"].stringValue
        }
        
        qualifications = [Qualification]()
        let qualificationsArray = json["qualifications"].arrayValue
        for qualificationsJson in qualificationsArray{
            let value = Qualification(fromJson: qualificationsJson)
            qualifications.append(value)
        }
        
       
//        reviews = [Review]()
//        let reviewsArray = json["reviews"].arrayValue
//        for reviewsJson in reviewsArray{
//            let value = Review(fromJson: custArrayJson)
//            custArray.append(value)
//        }
//        ssn = json["ssn"].stringValue
//        sts = json["sts"].stringValue
//        telecom = [Telecom]()
//        let telecomArray = json["telecom"].arrayValue
//        for telecomJson in telecomArray{
//            let value = Telecom(fromJson: custArrayJson)
//            custArray.append(value)
//        }
    
    
}
}
