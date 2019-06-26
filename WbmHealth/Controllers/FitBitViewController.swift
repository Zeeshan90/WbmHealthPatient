//
//  FitBitViewController.swift
//  WbmHealth
//
//  Created by Zeeshan on 25/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import ProgressHUD

class FitBitViewController: UIViewController,UIWebViewDelegate {

    
    @IBOutlet weak var webVu: UIWebView!
    var accessString: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webVu.delegate = self

        webVu.loadRequest(NSURLRequest(url: NSURL(string: "https://accounts.fitbit.com/login?targetUrl=https%3A%2F%2Fwww.fitbit.com%2Flogin%2Ftransferpage%3Fredirect%3Dhttps%25253A%25252F%25252Fwww.fitbit.com%25252Foauth2%25252Fauthorize%25253Fclient_id%25253D22DG2M%252526redirect_uri%25253Dhttps%2525253A%2525252F%2525252Fwbmchat.com%2525252Fpatient%2525252Ffitbit%2525252Fcallback%2525252Fdata%252526response_type%25253Dcode%252526scope%25253Dactivity%25252Bheartrate%25252Blocation%25252Bnutrition%25252Bprofile%25252Bsettings%25252Bsleep%25252Bsocial%25252Bweight%252526state&lcl=en_GB")! as URL) as URLRequest)
       
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func crossBtn(_ sender: Any) {
        ProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
    
        accessString = webVu.stringByEvaluatingJavaScript(from: "document.body.textContent")!
        print(accessString)
//
//        let array = accessString.characters.split(separator: "/").map(String.init)
        
       // let accessToken: String = array[0]
//        let userId: String = array[2]
//        let refreshToken : String = array[1]
        //dismiss(animated: true, completion: nil)
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        ProgressHUD.dismiss()
    }
    
  
    
}
