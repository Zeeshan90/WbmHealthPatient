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
    
    
    
    func returnAppointReq() -> [String:Any]{
        let requestArr: [String:Any] = [
            "apptDate":"\(apptDate)",
            "apptTime": "\(apptTime)",
            "patient": "\(patientId)",
            "doctor": "\(doctorId)",
            "resourceId": "\(resourceId)" as Any,
            "apptReason": "\(apptReason)",
            "email": email
        ]
        return requestArr
    }
}
