//
//  SleepViewController.swift
//  FloatSchwabing
//
//  Created by Michael Schlicker on 29.06.16.
//  Copyright © 2016 AndiThaler. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit




class SleepViewController: UIViewController {

    
    var videostreamURLs:[NSURL] = []
    
    var player: AVPlayer!
    
    let playerController = AVPlayerViewController()
    var videonr = 0;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlstr = NSUserDefaults.standardUserDefaults().stringForKey("urlkey")
        let dataArr = urlstr!.characters.split{$0 == ";"}.map(String.init)
        
        for singleurl in dataArr{
            var addstring = ""
            if singleurl.containsString("\n"){
                addstring = singleurl.substringFromIndex(singleurl.startIndex.advancedBy(1))
            } else {
                addstring = singleurl
            }
            videostreamURLs.append(NSURL(string: addstring)!)
        }
        player = AVPlayer(URL: videostreamURLs[0])
        playerController.player = player
        playerController.showsPlaybackControls=false
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame
        playVideo(0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playVideo(number:Int) {
        
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        player = AVPlayer(URL: videostreamURLs[number])
        playerController.player = player
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SleepViewController.playerDidFinishPlaying(_:)),name: AVPlayerItemDidPlayToEndTimeNotification, object: player.currentItem)
        player.muted = true
        player.play()
        print("start nr ")
        print(number)
    }

    func playerDidFinishPlaying(note: NSNotification) {
        newRound()
    }
    
    func newRound(){
        print("Video Finished")
        if videonr < (videostreamURLs.count - 1){
            videonr = videonr+1;
            print("add")
        } else {
            videonr = 0
            print("reset")
        }
        playVideo(
            videonr)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
