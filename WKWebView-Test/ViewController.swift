//
//  ViewController.swift
//  WKWebView-Test
//
//  Created by Admin on 2016-09-26.
//  Copyright © 2016 ToyBox Media. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var myWebView: MyWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myWebView.webView.navigationDelegate = self
        
        myWebView.webView.addObserver(self, forKeyPath: "loading" , options: .new, context: nil)
        myWebView.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        myWebView.webView.allowsBackForwardNavigationGestures = true


        let url = URL(string:"https://appcoda.com")
        let request = URLRequest(url:url!)
        myWebView.webView.load(request)
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        myWebView.webView.removeObserver(self, forKeyPath: "loading")
        myWebView.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated && !(navigationAction.request.url?.host?.localizedLowercase.hasPrefix("https://appcoda.com"))!{
            decisionHandler(.cancel)
        }else{
            decisionHandler(.allow)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if keyPath == "loading" {
            backButton.isEnabled = myWebView.webView.canGoBack
            forwardButton.isEnabled = myWebView.webView.canGoForward
        }else if keyPath == #keyPath(WKWebView.estimatedProgress) {
            progressView.isHidden = myWebView.webView.estimatedProgress == 1
            progressView.setProgress(Float(myWebView.webView.estimatedProgress), animated: true)
        }

    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        myWebView.webView.goBack()
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIBarButtonItem) {
        myWebView.webView.goForward()
    }

}

