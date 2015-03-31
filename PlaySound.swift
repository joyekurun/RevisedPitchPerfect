//
//  PlaySound.swift
//  PitchPerfect
//
//  Created by Amrit Joyekurun on 3/24/15.
//  Copyright (c) 2015 Amrit Joyekurun. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySound: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Stop fuction for all audio
    func clearAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    //combined fuction for playing rate: float
    
    func playAudioSpeed(rate: Float) {
        clearAudio()
        
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    // snail button
    @IBAction func PlayAudio(sender: UIButton)
    {
        playAudioSpeed(1.0)
    }
    
    // rabit button
    @IBAction func fastPlayAudio(sender: UIButton)
    {
        playAudioSpeed(2.0)
    }
    
    // combined fuction for pitch: float
    
    func playAudioWithVariablePitch(pitch: Float)
    {
        clearAudio()
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    // chimpmunk button
    @IBAction func playChimpmunkAudio(sender: UIButton)
    {
        playAudioWithVariablePitch(1000)
    }
    
    // darthvader button
    @IBAction func playDarthvaderAudio(sender: UIButton)
    {
        playAudioWithVariablePitch(-1000)
    }
    
    // stop button
    @IBAction func stopAll(sender: AnyObject)
    {
        clearAudio()
    }
    
}




