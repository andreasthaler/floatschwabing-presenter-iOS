//
//  AdvantagesViewController.swift
//  FloatSchwabing
//
//  Created by Andreas Thaler on 06.04.16.
//  Copyright © 2016 AndiThaler. All rights reserved.
//

import UIKit

class AdvantagesViewController: UIViewController,UIWebViewDelegate, UIScrollViewDelegate {

    var SwiftTimer = NSTimer()
    
    func startTimer() {
        SwiftTimer = NSTimer.scheduledTimerWithTimeInterval(120, target:self, selector: #selector(self.sleep), userInfo: nil, repeats: true)
    }
    
    
    
    func sleep() {
        print("App will go to sleep mode")
        resetTimer()
        performSegueWithIdentifier("advantagestosleepsegue", sender: nil)
    }
    
    func resetTimer() {
        SwiftTimer.invalidate()
    }
    
    override func viewDidAppear(animated: Bool) {
        resetTimer()
        startTimer()
    }
    
    override func viewWillDisappear(animated: Bool) {
        resetTimer()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        resetTimer()
        startTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.scrollView.delegate = self
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBOutlet weak var webView: UIWebView!
    let url = "http://www.float-schwabing.de/vorteile"
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        switch navigationType {
        case .LinkClicked:
            return false
        default:
            return true
        }
    }}
    


