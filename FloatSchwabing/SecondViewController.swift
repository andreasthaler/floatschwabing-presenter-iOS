//
//  SecondViewController.swift
//  FloatSchwabing
//
//  Created by Andreas Thaler on 05.04.16.
//  Copyright © 2016 AndiThaler. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIWebViewDelegate {

    var SwiftTimer = NSTimer()
    
    func startTimer() {
        SwiftTimer = NSTimer.scheduledTimerWithTimeInterval(120, target:self, selector: #selector(self.sleep), userInfo: nil, repeats: true)
    }
    
    
    
    func sleep() {
        print("App will go to sleep mode")
        resetTimer()
        performSegueWithIdentifier("secondtosleepsegue", sender: nil)
    }
    func resetTimer() {
        SwiftTimer.invalidate()    }
    
    override func viewDidAppear(animated: Bool) {
        resetTimer()
        startTimer()
    }
    
    override func viewWillDisappear(animated: Bool) {
        resetTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
        webView.delegate = self
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        switch navigationType {
        case .LinkClicked:
            return false
        default:
            return true
        }
    }
    
    @IBOutlet weak var webView: UIWebView!
    let url = "http://www.float-schwabing.de/pano/index.html"
    
}

