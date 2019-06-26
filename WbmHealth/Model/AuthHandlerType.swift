//
//  AuthHandlerType.swift
//  WbmHealth
//
//  Created by Zeeshan on 25/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import SafariServices
import AuthenticationServices

typealias AuthHandlerCompletion = (URL?, Error?) -> Void

protocol AuthHandlerType: class {
    var session: NSObject? { get set }
    func auth(url: URL, callbackScheme: String, completion: @escaping AuthHandlerCompletion)
}

extension AuthHandlerType {
    
    func auth(url: URL, callbackScheme: String, completion: @escaping AuthHandlerCompletion) {
        if #available(iOS 12, *) {
            let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackScheme) {
                url, error in
                completion(url, error)
            }
            session.start()
            self.session = session
        } else {
            let session = SFAuthenticationSession(url: url, callbackURLScheme: callbackScheme) {
                url, error in
                completion(url, error)
            }
            session.start()
            self.session = session
        }
    }
    
}
