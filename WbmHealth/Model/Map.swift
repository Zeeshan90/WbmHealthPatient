//
//  Map.swift
//  WbmHealth
//
//  Created by Zeeshan on 11/07/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON

class Map{
    
    var id : String!
    var address : String!
    var branchesCount : Int!
    var hospitalid : Int!
    var hospitalName : String!
    var coordinate: [String]!
    var branches : [Branche]!
    var laboratoryName:String!
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        address = json["address"].stringValue
        branches = [Branche]()
        let branchesArray = json["branches"].arrayValue
        for branchjson in branchesArray{
            let value = Branche(fromJson: branchjson)
            branches.append(value)

        }
        branchesCount = json["branches_count"].intValue
        hospitalid = json["hospitalid"].intValue
        hospitalName = json["hospitalName"].stringValue
        laboratoryName = json["laboratoryName"].stringValue
    }
}

class BranchAddress {
    
    
    var address: String?
    var city: String?
    
    init(json: JSON) {
        
        if json.isEmpty{
            return
        }
        address = json["address1"].stringValue
        city = json["city"].stringValue
        }
        
}


class Branche{
    
    var branchAddress : BranchAddress!
    var branchName : String?
    var location : Location!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let branchAddressJson = json["branchAddress"]
        if !branchAddressJson.isEmpty{
            branchAddress = BranchAddress(json: branchAddressJson)
        }
        branchName = json["branchName"].stringValue
        let locationJson = json["location"]
        if !locationJson.isEmpty{
            location = Location(fromJson: locationJson)
        }
    }
}


class Location{
    
    var coordinates : [Double]!
    var type : String!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        coordinates = [Double]()
        let coordinatesArray = json["coordinates"].arrayValue
        for coordinatesJson in coordinatesArray{
            coordinates.append(coordinatesJson.doubleValue)
        }
        type = json["type"].stringValue
    }
}
