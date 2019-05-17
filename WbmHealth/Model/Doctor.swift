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
    var address : [String]!
    var availability : [String]!
    var availableLbl: String?
    var birthDay : String!
    var contacts : [AnyObject]!
    var doctorName : String!
    var doctorSpeciality : String!
    var experience : [String]!
    var gender : String!
    var hospitals : AnyObject!
    var intervals : [String]!
    var language : [String]!
    var languageLbl: String?
    var maxfee : String!
    var minfee : String!
    var password : String!
    var photo : [Photo]!
    var image: String!
    var qualifications : [String]!
    var ssn : String!
    var sts : String!
    var telecom : [String]!
    
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
        
        // getting Address from the json
        address = [String]()
        let addressArray = json["address"].arrayValue
        for addressJson in addressArray{
            address.append(addressJson.stringValue)
        }
        print(address)
        
        // Getting All the Availabilities
        availability = [String]()
        let availabilityArray = json["availability"].arrayValue
        for availabilityJson in availabilityArray{
            let availdays = availabilityJson["availDays"].stringValue
            availability.append(availdays)
        }
        print(availability)
        availableLbl = availability.joined(separator: ",")
        birthDay = json["birthDay"].stringValue  // getting Birthday of doc
        
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
        
        
        intervals = [String]()
        let intervalsArray = json["intervals"].arrayValue
        for intervalsJson in intervalsArray{
            intervals.append(intervalsJson.stringValue)
        }
        print(intervals)
        
        // getting Languages of the doctors
        language = [String]()
        let languageArray = json["language"].arrayValue
        for languageJson in languageArray{
            language.append(languageJson.stringValue)
        }
        print(language)
        let languageString = language.joined(separator: ",")
        print(languageString)
        languageLbl = languageString
        
        
        maxfee = json["maxfee"].stringValue
        minfee = json["minfee"].stringValue
        password = json["password"].stringValue
        
        // Photo Of the doctor
        photo = [Photo]()
        let photoArray = json["photo"].arrayValue
        for photoJson in photoArray{
            image = photoJson["url"].stringValue
        }
        
        // Qualification of the doctor
        qualifications = [String]()
        let qualificationsArray = json["qualifications"].arrayValue
        for qualificationsJson in qualificationsArray{
            qualifications.append(qualificationsJson.stringValue)
        }
        ssn = json["ssn"].stringValue
        sts = json["sts"].stringValue
        
        telecom = [String]()
        let telecomArray = json["telecom"].arrayValue
        for telecomJson in telecomArray{
            telecom.append(telecomJson.stringValue)
        }
    

}
}
