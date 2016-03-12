//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Marcin Lament on 18/02/2016.
//  Copyright © 2016 Marcin Lament. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer : AVAudioPlayer!
    var receivedAudio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine();
        audioFile = try! AVAudioFile(forReading: receivedAudio.url);

        audioPlayer = try! AVAudioPlayer.init(contentsOfURL: receivedAudio.url);
        audioPlayer.enableRate = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playFastSound(sender: AnyObject) {
        playSoundAtRate(1.5);
    }
    
    @IBAction func playSlowSound(sender: AnyObject) {
        playSoundAtRate(0.5);
    }
    
    @IBAction func playDarthvaderSound(sender: AnyObject) {
        playSoundWithVariablePitch(-1000);
    }
    
    @IBAction func playChipmunkSound(sender: AnyObject) {
        playSoundWithVariablePitch(1000);
    }
    
    func playSoundWithVariablePitch(pitch: Float){
        stopPlayer();
        
        let audioPlayerNode = AVAudioPlayerNode();
        audioEngine.attachNode(audioPlayerNode);
        
        let changePitchEffect = AVAudioUnitTimePitch();
        changePitchEffect.pitch = pitch;
        audioEngine.attachNode(changePitchEffect);
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil);
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil);
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil);
        try! audioEngine.start();
        
        audioPlayerNode.play();
    }
    
    func playSoundAtRate(speed : Float){
        stopPlayer();
        
        audioPlayer.rate = speed;
        audioPlayer.currentTime = 0;
        audioPlayer.play();
    }

    @IBAction func stopSound(sender: AnyObject) {
        stopPlayer();
    }
    
    func stopPlayer(){
        audioPlayer.stop();
        audioEngine.stop();
        audioEngine.reset();
    }
}
