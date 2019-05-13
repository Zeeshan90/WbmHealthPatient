//
//  WbmDefaults.swift
//  WbmHealth
//
//  Created by WBM on 5/2/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import GoogleMaps


class WbmDefaults{
    
    static let instance = WbmDefaults()
    static let defaults = UserDefaults.standard
    static let AppState = "AppState"
    
    func setAppState( value : String )
    {
        WbmDefaults.defaults.set(value,forKey: WbmDefaults.AppState)
    }
    
    func getAppState()-> String {
        return WbmDefaults.defaults.string(forKey: WbmDefaults.AppState) ?? ""
    }
    func setString( key : String,value : String )
    {
        WbmDefaults.defaults.set(value,forKey: key)
    }
    
    func getString(key : String) -> String {
        return WbmDefaults.defaults.string(forKey: key) ?? ""
    }
    
    func setInt( key : String,value : Int )
    {
        WbmDefaults.defaults.set(value,forKey: key)
    }
    func getInt(key : String) -> Int {
        return WbmDefaults.defaults.integer(forKey: key) 
    }
    func setDouble( key : String,value : Double )
    {
        WbmDefaults.defaults.set(value,forKey: key)
    }
    func getDouble(key : String) -> Double {
        return WbmDefaults.defaults.double(forKey: key) 
    }
    func setBool( key : String,value : Bool )
    {
        WbmDefaults.defaults.set(value,forKey: key)
    }
    func getBool(key : String) -> Bool {
        return WbmDefaults.defaults.bool(forKey: key) 
    }
    func setDate( key : String,value : Date )
    {
        WbmDefaults.defaults.set(value,forKey: key)
    }
    func getDate(key : String) -> Date {
        return WbmDefaults.defaults.object(forKey: key) as! Date
    }
    func setLocation( key : String,value : CLLocationCoordinate2D )
    {
        WbmDefaults.defaults.set(value,forKey: key)
    }
    func getLocation(key : String) -> CLLocationCoordinate2D {
        return WbmDefaults.defaults.object(forKey: key) as! CLLocationCoordinate2D
    }
   
    func setFireBaseToken( value : String )
    {
        WbmDefaults.defaults.set(value,forKey: "FireBaseToken")
    }
    func getFireBaseToken() -> String {
        return WbmDefaults.defaults.string(forKey: "FireBaseToken") ?? ""
    }
}
