//
//  MenuScene.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/11/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit
import AVFoundation
import UIKit
import GameplayKit

class MenuScene: SKScene {
    
    let playButton = SKLabelNode(text: "PLAY")
    let earth = SKSpriteNode(imageNamed: "earth.png")
    let moon = SKSpriteNode(imageNamed: "earth5.png")
    let rightAlien = SKSpriteNode(imageNamed: "alien1.png")
    let leftAlien = SKSpriteNode(imageNamed: "alien2.png")
    
    override func didMove(to view: SKView) {
        
        playBGMusic()
        setBG()
        backgroundColor = .yellow
        
    }
    
    func beginDialog() {
        
        let lText:String = "We are almost *out of Earth stuff. *Go and restock!"
        let leftDialog = DialogBox(text: lText)
        leftDialog.position = CGPoint(x: leftAlien.position.x - leftAlien.size.width * 0.5, y: leftAlien.position.y + leftAlien.size.height * 0.8)
        leftDialog.zPosition = leftAlien.zPosition
        addChild(leftDialog)
        
        let rText = "Yes Boss, those *humans won't know *what hit them."
        let rightDialog = DialogBox(text: rText)
        rightDialog.position = CGPoint(x: rightAlien.position.x + rightAlien.size.width * 0.5, y: rightAlien.position.y + rightAlien.size.height * 0.8)
        rightDialog.zPosition = rightAlien.zPosition
        addChild(rightDialog)
    }
    
    func setBG() {
        
        let bg = SKSpriteNode(imageNamed: "starsBG.png")
        bg.zPosition = bgZPosition
        bg.position = centerScreen
        addChild(bg)
        
        let title = SKLabelNode(text: "Retro Aliens")
        title.fontColor = custBlue
        title.fontSize = 50.0
        title.fontName = globalFont
        title.zPosition = bg.zPosition + 2
        title.position = CGPoint(x: centerX, y: deviceHeight * 0.85)
        addChild(title)
        
        let moonHeight = deviceHeight * 0.75
        moon.size = CGSize(width: moonHeight, height: moonHeight)
        moon.position = centerScreen
        moon.zPosition = bg.zPosition + 1
        addChild(moon)
        
        playButton.fontSize = 48.0
        playButton.fontColor = custBlue
        playButton.fontName = globalFont
        playButton.zPosition = moon.zPosition + 1
        playButton.position = CGPoint(x: centerX, y: deviceHeight * 0.1)
        addChild(playButton)
        let sequence = SKAction.sequence([SKAction.fadeOut(withDuration: 0.9),SKAction.fadeIn(withDuration: 0.9)])
        playButton.run(SKAction.repeatForever(sequence))
        
        let alienWidth:CGFloat = deviceHeight * 0.35
        let alienSize = CGSize(width: alienWidth, height: alienWidth * 1.5)
        let alienY:CGFloat = 0.0 + alienSize.height / 2
        rightAlien.size = alienSize
        rightAlien.position = CGPoint(x: deviceWidth * 0.75, y: alienY)
        rightAlien.zPosition = alienZPosition
        //addChild(rightAlien)
        
        leftAlien.size = alienSize
        leftAlien.position = CGPoint(x: deviceWidth * 0.25, y: alienY)
        leftAlien.zPosition = alienZPosition
        //addChild(leftAlien)
        
        //delay(1.0, completion: {
        //    self.beginDialog()
        //})
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            
            if playButton.contains(location) {
                //go to game scene
                transitionScene(nextScene: GameScene(), currScene: self)
            }
            
            
        }
    }


}
