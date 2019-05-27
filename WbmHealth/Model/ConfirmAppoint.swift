//
//  ConfirmAppoint.swift
//  WbmHealth
//
//  Created by WBM on 5/27/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON


class ConfirmAppoint {
    
    var v : Int!
    var id : String!
    var apptDate : String!
    var apptReason : String!
    var apptTime : String!
    var createdAt : String!
    //var doctor : Doctor!
    var email : String!
    //var patient : Patient!
    var resourceId : String!
    var status : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        v = json["__v"].intValue
        id = json["_id"].stringValue
        apptDate = json["apptDate"].stringValue
        apptReason = json["apptReason"].stringValue
        apptTime = json["apptTime"].stringValue
        createdAt = json["createdAt"].stringValue
//        let doctorJson = json["doctor"]
//        if !doctorJson.isEmpty{
//            doctor = Doctor(fromJson: doctorJson)
//        }
        email = json["email"].stringValue
        let patientJson = json["patient"]
//        if !patientJson.isEmpty{
//            patient = Patient(fromJson: patientJson)
//        }
        resourceId = json["resourceId"].stringValue
        status = json["status"].stringValue
    }
    
}
