//
//  VideoViewController.swift
//  AudioVideoTest
//
//  Created by Infraestructura on 22/10/16.
//  Copyright © 2016 Infraestructura. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UISplitViewController
{
    var videoPlayer:AVPlayer?
    var visto:Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let urlVideo = NSBundle.mainBundle().URLForResource("Comex-Omnilife", withExtension: "mp4")
        
        self.videoPlayer = AVPlayer(URL: urlVideo!)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if(!visto)
        {
            self.muestraVideo()
        }
    }
    
    func muestraVideo()
    {
        let videoPlayercontroller = AVPlayerViewController()
        
        videoPlayercontroller.player = self.videoPlayer!
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone)
        {
            self.presentViewController(videoPlayercontroller, animated: true, completion:
            {
                self.videoPlayer!.play()
                
                self.visto = true
            })
            
        } else {
            
            let framePantalla = UIScreen.mainScreen().bounds
            let anchoPantalla = CGRectGetWidth(framePantalla)
            let altoPantalla  = CGRectGetWidth(framePantalla)
            
            videoPlayercontroller.view.frame = CGRectMake(anchoPantalla/3, altoPantalla/3, anchoPantalla/3, altoPantalla/3)
            
            self.view.addSubview(videoPlayercontroller.view)
            self.addChildViewController(videoPlayercontroller)
            
            self.videoPlayer!.play()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
