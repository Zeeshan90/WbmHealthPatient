//
//  Speciality.swift
//  WbmHealth
//
//  Created by WBM on 5/9/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON
class Speciality {
        
        var id : String!
        var photo : [AnyObject]!
        var specialityDesc : String!
        
        /**
         * Instantiate the instance using the passed json values to set the properties values
         */
        init(fromJson json: JSON!){
            if json.isEmpty{
                return
            }
            id = json["_id"].stringValue
            specialityDesc = json["speciality_desc"].stringValue
            photo = [Int]() as [AnyObject]
            let photoArray = json["photo"].arrayValue
            print(photoArray)
            for photoJson in photoArray{
               // image = photoJson["url"].stringValue
                photo.append(photoJson["url"].string as AnyObject)
            }
            
        }
        
      
        
    }
