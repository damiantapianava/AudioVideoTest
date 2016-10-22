//
//  ViewController.swift
//  AudioVideoTest
//
//  Created by Infraestructura on 22/10/16.
//  Copyright © 2016 Infraestructura. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController, AVAudioPlayerDelegate
{

    var audioPlayer:AVAudioPlayer?
    
    var timer:NSTimer?
    
    @IBAction func sliderVolumeChange(sender: AnyObject)
    {
        self.audioPlayer!.volume = self.sliderVolume.value
    }

    @IBAction func sliderDuracionChange(sender: AnyObject)
    {
        
    }
    
    @IBAction func btnPlayClick(sender: AnyObject)
    {
        self.audioPlayer!.play()
        self.btnPlay.enabled = false;
        self.btnStop.enabled = true;
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(AudioViewController.actualizaSlider), userInfo: nil, repeats: true)
    }

    @IBAction func btnStopClick(sender: AnyObject)
    {
        self.audioPlayer!.stop()
        self.btnStop.enabled = false;
        self.btnPlay.enabled = true;
    }

    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var sliderDuracion: UISlider!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let strPath = NSBundle.mainBundle().pathForResource("Dillon-13-36", ofType: "mp3")
        
        let urlAudio = NSURL.fileURLWithPath(strPath!)
        
        self.cargarAudio(urlAudio)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        self.btnStopClick(self.btnStop)
        
        self.inicializaUX()
    }
    
    private func cargarAudio(url: NSURL)
    {
        do
        {
            try self.audioPlayer = AVAudioPlayer(contentsOfURL: url)
            
            self.audioPlayer!.delegate = self
            
            self.audioPlayer!.prepareToPlay()
            
            self.inicializaUX()
            
        } catch {
            
            let ac = UIAlertController(title: "Error", message: "Archivo de audio no compatible", preferredStyle: .Alert)
            
            let ab = UIAlertAction(title: "ya que ...", style: .Default, handler: nil)
            
            ac.addAction(ab)
            
            self.presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    private func inicializaUX()
    {
        self.btnStop.enabled = false
        self.sliderVolume.minimumValue = 0.0
        self.sliderVolume.maximumValue = 1.0
        self.sliderVolume.value = 0.5
        
        self.audioPlayer!.volume = self.sliderVolume.value
        
        self.audioPlayer!.currentTime = 0.0
        
        self.sliderDuracion.minimumValue = 0.0
        
        let laDuracion:Double = self.audioPlayer!.duration
        
        self.sliderDuracion.maximumValue = Float(laDuracion)
        
        self.sliderDuracion.value = 0.0
    }
    
    func actualizaSlider()
    {
        let currentTime:Double = self.audioPlayer!.currentTime
        
        self.sliderDuracion.value = Float(currentTime)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }


}

