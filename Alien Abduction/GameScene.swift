//
//  GameScene.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/11/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let bg = SKSpriteNode(imageNamed: "cityBG.png")
    let alienShip = SKSpriteNode(imageNamed: "alienShip.png")
    var isCloaked: Bool = false
    var powerLevel:CGFloat = 100
    var gameTimer:Timer!
    var selectedAbductee:Abductee?
    var abductees:[Abductee] = []
    var tractorBeam:TractorBeam?
    
    override func didMove(to view: SKView) {
        
        setBackground()
        setAlienShip()
        setAbducteesInView()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runGameTimer), userInfo: nil, repeats: true)
    }
    override func willMove(from view: SKView) {
        gameTimer.invalidate()
    }
    
    func runGameTimer() {
        
        cloakAlienShip()
    }
    
    func setAbducteesInView() {
        //randomly set and position abductees
        setNewAbductee()
    }
    
    func setNewAbductee() {
        
        let man = Abductee(texture: SKTexture(imageNamed: "man1.png"), color: .white, size: CGSize(width: 40.0, height: 60.0), points: 1200)
        man.zPosition = bg.zPosition + 1
        man.position = CGPoint(x: centerX, y: deviceHeight * 0.2)
        addChild(man)
        abductees.append(man)
    }
    
    func setTractorBeam() {
        //get position of alien ship and position of selected abductee
        let tb = TractorBeam(shipPosition: alienShip.position, abPosition: (selectedAbductee?.position)!)
        
        //add tractor beam to view
        addChild(tb)
    }
    
    func cloakAlienShip() {
        
        if !isCloaked {
            isCloaked = true
            alienShip.run(SKAction.fadeAlpha(to: 0.3, duration: 0.7))
        }
        else {
            isCloaked = false
            alienShip.run(SKAction.fadeAlpha(to: 1.0, duration: 0.7))
        }
        
    }
    
    func setAlienShip() {
        alienShip.zPosition = bg.zPosition + 1
        alienShip.position = CGPoint(x: centerX, y: deviceHeight * 0.85)
        addChild(alienShip)
    }
    
    func setBackground() {
        bg.size = CGSize(width: deviceWidth, height: deviceHeight)
        bg.position = centerScreen
        bg.zPosition = bgZPosition
        addChild(bg)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            
            for ab in abductees {
                if ab.contains(location) {
                    //set tractor beam
                    selectedAbductee = ab
                    setTractorBeam()
                    print("Abductee was selected")
                    break
                }
            }
            
            //            if newProfileButton.contains(location) {
            //                //go to new profile scene
            //                transitionScene(nextScene: NewProfileScene(), currScene: self)
            //            }
            //
            //            if settingsButton.contains(location) {
            //                //go back to menu Scene
            //                transitionScene(nextScene: SettingsScene(), currScene: self)
            //                
            //            }
            
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

    }
}
