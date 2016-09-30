//
//  MyWebView.swift
//  WKWebView-Test
//
//  Created by Admin on 2016-09-26.
//  Copyright © 2016 ToyBox Media. All rights reserved.
//

import UIKit
import WebKit

class MyWebView: UIView {

    
    var webView:WKWebView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        let config = WKWebViewConfiguration()
        let scriptURL = Bundle.main.path(forResource: "hideNav", ofType: "js")!
        let scriptContent = try! String(contentsOfFile: scriptURL, encoding: .utf8)
        let script = WKUserScript(source: scriptContent, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)

        webView = WKWebView(frame: CGRect.zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(webView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        webView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
}
