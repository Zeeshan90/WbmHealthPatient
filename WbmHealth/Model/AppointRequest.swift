//
//  AppointRequest.swift
//  WbmHealth
//
//  Created by WBM on 5/24/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation

class AppointRequest{
    
    var apptDate: String!
    var apptTime: String!
    var patientId: String!
    var doctorId: String!
    var resourceId: String?
    var apptReason: String!
    var email: String!
    var interval: String!
    var date: String!
    var carePlan = [String]()
    var vaccination = [String]()
    var medication = [String]()
    
    func returnAppointReq() -> [String:Any]{
        let requestArr: [String:Any] = [
            "appointment":[
            "apptDate":"\(apptDate!)",
            "apptTime": "\(apptTime!)",
            "patient": "\(patientId!)",
            "doctor": "\(doctorId!)",
            "resourceId": "\(resourceId ?? "")" as Any,
            "apptReason": "\(apptReason!)",
            "email": "\(email!)",
            "carePlan": carePlan,
            "vaccination": vaccination,
            "medication": medication,
            ],
            "notification": [
                "intervals": "\(apptTime ?? "")",
                "date": "\(apptDate ?? "")",
                "doctorId": "\(doctorId ?? "")"
            ]
        ]
        return requestArr
    }
}
