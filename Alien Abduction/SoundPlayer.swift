//
//  SoundPlayer.swift
//  Retro Aliens
//
//  Created by Ramiro Beltran on 5/16/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit
import AVFoundation

var musicPlayer: AVAudioPlayer?
var soundClipPlayer: AVAudioPlayer?
var effectPlayer: AVAudioPlayer?
var zoomPlayer: AVAudioPlayer?
var playerPlaying = false

func playBGMusic() {
    let url = Bundle.main.url(forResource: "bgMusic2", withExtension: "wav")!
    
    if playerPlaying {
        return
    }
    do {
        print("launching new avaudio player")
        musicPlayer = try AVAudioPlayer(contentsOf: url)
        guard let player = musicPlayer else { return }
        
        player.prepareToPlay()
        player.volume = 0.40
        player.play()
        player.numberOfLoops = -1
        playerPlaying = true
    } catch let error {
        print(error.localizedDescription)
    }
}
func playLowBattery() {
    let taunts = ["needMoreInput","runningOutOfJuice"]
    let randomNum = getRandomNumber(max: taunts.count - 1)
    let url = Bundle.main.url(forResource: taunts[randomNum], withExtension: "mp3")!
    
    
    do {
        print("launching new avaudio player")
        soundClipPlayer = try AVAudioPlayer(contentsOf: url)
        guard let player = soundClipPlayer else { return }
        
        player.prepareToPlay()
        player.play()
        player.numberOfLoops = 0
        //playerPlaying = true
    } catch let error {
        print(error.localizedDescription)
    }
}
func playTaunt() {
    let taunts = ["laugh","youllRegret","sucker","whatsYourDamage"]
    let randomNum = getRandomNumber(max: taunts.count - 1)
    let url = Bundle.main.url(forResource: taunts[randomNum], withExtension: "mp3")!

    
    do {
        print("launching new avaudio player")
        soundClipPlayer = try AVAudioPlayer(contentsOf: url)
        guard let player = soundClipPlayer else { return }
        
        player.prepareToPlay()
        player.play()
        player.numberOfLoops = 0
        //playerPlaying = true
    } catch let error {
        print(error.localizedDescription)
    }
}
func playScoreSound() {
    let sounds = ["score","dontMind","claimed","likeSand","radical","needThis","radSauce"]
    let randomNum = getRandomNumber(max: sounds.count - 1)
    let url = Bundle.main.url(forResource: sounds[randomNum], withExtension: "mp3")!
    
    do {
        print("launching new avaudio player")
        soundClipPlayer = try AVAudioPlayer(contentsOf: url)
        guard let player = soundClipPlayer else { return }
        
        player.prepareToPlay()
        player.play()
        player.numberOfLoops = 0
        //playerPlaying = true
    } catch let error {
        print(error.localizedDescription)
    }
}
func playBeamSound() {
    let url = Bundle.main.url(forResource: "beamSound", withExtension: "mp3")!
    
    do {
        print("launching new avaudio player")
        soundClipPlayer = try AVAudioPlayer(contentsOf: url)
        guard let player = soundClipPlayer else { return }
        
        player.prepareToPlay()
        player.play()
        player.volume = 1.0
        player.numberOfLoops = 0
        //playerPlaying = true
    } catch let error {
        print(error.localizedDescription)
    }
}

func playSplashSound() {
    let url = Bundle.main.url(forResource: "splash", withExtension: "mp3")!
    
    do {
        print("launching new avaudio player")
        effectPlayer = try AVAudioPlayer(contentsOf: url)
        guard let effectPlayer = effectPlayer else { return }
        
        effectPlayer.prepareToPlay()
        effectPlayer.play()
        effectPlayer.numberOfLoops = 0
        //playerPlaying = true
    } catch let error {
        print(error.localizedDescription)
    }
}
