//
//  PrivacyPolicyViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/30/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import ProgressHUD

class PrivacyPolicyViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webVu: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webVu.delegate = self
        
        webVu.loadRequest(NSURLRequest(url: NSURL(string: "https://wbmhealth.com/privacy-policy/")! as URL) as URLRequest)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        ProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        ProgressHUD.show("Loading...")
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        ProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        ProgressHUD.dismiss()
    }
}
