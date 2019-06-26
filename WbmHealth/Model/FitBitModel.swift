//
//  FitBitModel.swift
//  WbmHealth
//
//  Created by Zeeshan on 25/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

struct Constants {
    
    static let authUrl = URL(string: "https://www.fitbit.com/oauth2/authorize")
    static let responseType = "code"
    static let clientId = "{YOUR_CLIENT_ID}"
    static let redirectScheme = "vialyx://" // YOU MUST DEFINE THAT SCHEME IN PROJECT SETTIGNS
    static let redirectUrl = "\(redirectScheme)fitbit/auth"
    static let scope = ["activity", "heartrate", "location", "nutrition", "profile", "settings", "sleep", "social", "weight"]
    static let expires = "604800"
    
    private init() {}
    
}

class FitBitModel: AuthHandlerType {
    
    var session: NSObject? = nil
    
    func auth(_ completion: @escaping ((String?, Error?) -> Void)) {
        guard let authUrl = Constants.authUrl else {
            completion(nil, nil)
            
            return
        }
        
        var urlComponents = URLComponents(url: authUrl, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "response_type", value: Constants.responseType),
            URLQueryItem(name: "client_id", value: Constants.clientId),
            URLQueryItem(name: "redirect_url", value: Constants.redirectUrl),
            URLQueryItem(name: "scope", value: Constants.scope.joined(separator: " ")),
            URLQueryItem(name: "expires_in", value: String(Constants.expires))
        ]
        
        guard let url = urlComponents?.url else {
            completion(nil, nil)
            
            return
        }
        
        auth(url: url, callbackScheme: Constants.redirectScheme) {
            url, error in
            if error != nil {
                completion(nil, error)
            } else if let `url` = url {
                guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                    let item = components.queryItems?.first(where: { $0.name == "code" }),
                    let code = item.value else {
                        completion(nil, nil)
                        
                        return
                }
                
                completion(code, nil)
            }
        }
    }
    
}
