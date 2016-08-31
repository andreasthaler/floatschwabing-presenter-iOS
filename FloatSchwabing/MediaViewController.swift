//
//  MediaViewController.swift
//  FloatSchwabing
//
//  Created by Andreas Thaler on 08.04.16.
//  Copyright © 2016 AndiThaler. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController,UIWebViewDelegate, UIScrollViewDelegate {

    var SwiftTimer = NSTimer()
    func startTimer() {
        SwiftTimer = NSTimer.scheduledTimerWithTimeInterval(120, target:self, selector: #selector(self.sleep), userInfo: nil, repeats: true)
    }
    
    
    
    func sleep() {
        print("App will go to sleep mode")
        resetTimer()
        performSegueWithIdentifier("mediatosleepsegue", sender: nil)
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        resetTimer()
        startTimer()
    }

    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webViewRight: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.scrollView.delegate = self
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
        webViewRight.delegate = self
        webViewRight.scrollView.delegate = self
        let requestURLRight = NSURL(string:urlRight)
        let requestRight = NSURLRequest(URL: requestURLRight!)
        webViewRight.loadRequest(requestRight)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    let url = "http://www.float-schwabing.de/centerinfo/bilder.html"
    let urlRight = "http://www.float-schwabing.de/centerinfo/videos.html"

    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        switch navigationType {
        case .LinkClicked:
            return false
        default:
            if ((request.URL!.absoluteString.containsString("https://m.youtube.com"))) {
                
                return false
            } else {
                
                return true
            }
        }
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        print(webView.request?.URL?.absoluteString)
    }

}


    

