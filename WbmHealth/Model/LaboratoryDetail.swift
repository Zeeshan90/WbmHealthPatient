//
//  LaboratoryDetail.swift
//  WbmHealth
//
//  Created by Zeeshan on 13/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON

class LaboratoryDetail{
    
    var id : String!
    var address : String!
    var branches : [AnyObject]!
    var branchesCount : Int!
    var chaintype : String!
    var createdAt : String!
    var descriptionField : String!
    var fax : String!
    var laboratoryCode : String!
    var laboratoryid : Int!
    var laboratoryName : String!
    var laboratoryType : String!
    var phone : String!
    var photo : String!
    var sts : String!
    var updatedAt : String!
    var web : String!
    var noofLabs: Int!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        address = json["address"].stringValue
        
        let branchesArray = json["branches"].arrayValue
        for branchesJson in branchesArray{
            
        }
        branchesCount = json["branchesCount"].intValue
        chaintype = json["chaintype"].stringValue
        
        let contactsArray = json["contacts"].arrayValue
        for contactsJson in contactsArray{
            
        }
        createdAt = json["createdAt"].stringValue
        descriptionField = json["description"].stringValue
        fax = json["fax"].stringValue
        laboratoryCode = json["laboratoryCode"].stringValue
        laboratoryid = json["laboratoryid"].intValue
        laboratoryName = json["laboratoryName"].stringValue
        laboratoryType = json["laboratoryType"].stringValue
        
        let labTestsArray = json["labTests"].arrayValue
        noofLabs = labTestsArray.count
        for labTestsJson in labTestsArray{
        
        }
        phone = json["phone"].stringValue
        
        let photoArray = json["photo"].arrayValue
        for photoJson in photoArray{
            photo = photoJson["url"].stringValue
        }
        sts = json["sts"].stringValue
        updatedAt = json["updatedAt"].stringValue
        web = json["web"].stringValue
    }
    
    
    
    
    
    
    
    
    
}
