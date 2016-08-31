//
//  FirstViewController.swift
//  FloatSchwabing
//
//  Created by Andreas Thaler on 05.04.16.
//  Copyright © 2016 AndiThaler. All rights reserved.
//

import UIKit

class FirstViewController: VideoSplashViewController {

    var SwiftTimer = NSTimer()
    
    func startTimer() {
        SwiftTimer = NSTimer.scheduledTimerWithTimeInterval(120, target:self, selector: #selector(self.sleep), userInfo: nil, repeats: true)
    }
    
    
    func sleep() {
        print("App will go to sleep mode")
        resetTimer()
        performSegueWithIdentifier("firsttosleepsegue", sender: nil)
    }
    
    func resetTimer() {
        print("reset Timer")
        SwiftTimer.invalidate()
    }
    
    func getURLArrayFromServer(){
        if let URL = NSURL(string: "http://lightbyte.beercrate.de/FloatSchwabingPresenterLinks.txt") {
            
            let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            let request = NSMutableURLRequest(URL: URL)
            request.HTTPMethod = "GET"
            let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if (error == nil) {
                    // Success
                    let statusCode = (response as! NSHTTPURLResponse).statusCode
                    print("Download of URLs | Success: \(statusCode)")
                    let dataString = String(data: data!, encoding: NSUTF8StringEncoding)!
                    NSUserDefaults.standardUserDefaults().setObject(dataString, forKey: "urlkey")
                }
                else {
                    // Failure
                    print("Download of URLs | Faulure: %@", error!.localizedDescription);
                }
            })
            task.resume()
        }
    }

    override func viewWillDisappear(animated: Bool) {
        resetTimer()
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupVideoBackground()
        getURLArrayFromServer()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidLoad()
        resetTimer()
        startTimer()
    }
    
    func setupVideoBackground()
    {
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("impressions", ofType: "MP4")!)
        
        videoFrame = view.frame
        fillMode = .ResizeAspectFill
        alwaysRepeat = true
        sound = false
        startTime = 2
        duration = 30
        alpha = 1
        
        contentURL = url
        view.userInteractionEnabled = false
    }
    
    private func setupButtons()
    {
          }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

