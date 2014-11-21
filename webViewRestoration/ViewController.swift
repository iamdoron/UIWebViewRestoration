//
//  ViewController.swift
//  webViewRestoration
//
//  Created by Doron Pagot on 11/21/14.
//  Copyright (c) 2014 Doron Pagot. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.scrollView.restorationIdentifier = "webViewScrollView"
    }

    var restoring = false
    override func viewDidAppear(animated: Bool) {
        if !restoring {
            webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://google.com")!))
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var restoredScrollOffset: CGPoint = CGPoint.zeroPoint
    override func applicationFinishedRestoringState() {
        restoring = true
        webView.reload()
        restoredScrollOffset = webView.scrollView.contentOffset
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if restoring {
            restoring = false
            if webView.scrollView.contentOffset != restoredScrollOffset {
                println("bug - sometimes it may happen")
            }
            webView.scrollView.contentOffset = restoredScrollOffset
        }
    }
}

