//
//  Doctor.swift
//  WbmHealth
//
//  Created by WBM on 5/13/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON
class Doctor{
    
    var v : Int!
    var id : String!
    var aboutme : String!
   // var address : [Addres]!
    //var availability : [Availability]!
    var birthDay : String!
    var contacts : [AnyObject]!
    var doctorName : String!
    var doctorSpeciality : String!
    //var experience : Experience!
    var gender : String!
    var hospitals : AnyObject!
    var intervals : String?
    var language : [String]!
    var maxfee : String!
    var minfee : String!
    var password : String!
    var photo : [Photo]!
    var image: String!
    //var qualifications : [Qualification]!
    var ssn : String!
    var sts : String!
   // var telecom : [Telecom]!
    
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
//       // address = [Addres]()
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
       // contacts = [Int]()
//        let contactsArray = json["contacts"].arrayValue
//        for contactsJson in contactsArray{
//            contacts.append(contactsJson.)
//        }
        let doctorNameJson = json["doctor_name"]
        let givenArray = doctorNameJson["given"].arrayValue
    
        doctorName = "\(givenArray[0]) \(givenArray[2])"
        doctorSpeciality = json["doctor_speciality"].stringValue
//        let experienceJson = json["experience"]
//        if !experienceJson.isEmpty{
//            experience = Experience(fromJson: experienceJson)
//        }
        gender = json["gender"].stringValue
        hospitals = json["hospitals"] as AnyObject
        //intervals = [String]()
        let intervalsArray = json["intervals"].arrayValue
       
//        for intervalsJson in intervalsArray[0]{
//
//                let arr  = (self.label.text ?? "")+" "+String(intervalsJson) //+"<space>"+ to +","+ if you need lap times are comma separated.
//                self.label.text = arr
//
//            intervals.append(intervalsJson.stringValue)
//        }
//        language = [Int]()
//        let languageArray = json["language"].arrayValue
//        for languageJson in languageArray{
//            language.append(languageJson.stringValue)
//        }
        maxfee = json["maxfee"].stringValue
        minfee = json["minfee"].stringValue
        password = json["password"].stringValue
        photo = [Photo]()
        let photoArray = json["photo"].arrayValue
        for photoJson in photoArray{
            image = photoJson["url"].stringValue
        }
//        qualifications = [Qualification]()
//        let qualificationsArray = json["qualifications"].arrayValue
//        for qualificationsJson in qualificationsArray{
//            let value = Qualification(fromJson: custArrayJson)
//            custArray.append(value)
//        }
        ssn = json["ssn"].stringValue
        sts = json["sts"].stringValue
        
//        telecom = [Telecom]()
//        let telecomArray = json["telecom"].arrayValue
//        for telecomJson in telecomArray{
//            let value = Telecom(fromJson: custArrayJson)
//            custArray.append(value)
//        }
    

}
}
