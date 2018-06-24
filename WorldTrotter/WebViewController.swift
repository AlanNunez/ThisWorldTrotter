//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Cristopher Nunez on 16/6/18.
//  Copyright © 2018 com.example.flia. All rights reserved.

import UIKit
import WebKit

class WebViewController : UIViewController, WKUIDelegate
{
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        print("Web view loaded")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}

