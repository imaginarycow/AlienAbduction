//
//  GameScene.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/11/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let backButton = SKLabelNode(text: "Back")
    let bg = SKSpriteNode(imageNamed: "cityBG.png")
    let alienShip = SKSpriteNode(imageNamed: "alienShip.png")
    
    var powerLevel:CGFloat = 100
    var gameTimer:Timer!
    var selectedAbductee:Abductee?
    var abductees:[Abductee] = []
    var tractorBeam:TractorBeam?
    var currNumberOfAbductees = 0
    
    //level booleans
    var isCloaked: Bool = false
    var tractorBeamInUse:Bool = false
    var abducteeWasSelected:Bool = false
    var abducteeIsInBeam:Bool = false

    
    override func didMove(to view: SKView) {
        
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
        
        setBackground()
        setButtons()
        setAlienShip()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runGameTimer), userInfo: nil, repeats: true)
        
        selectedAbductee?.physicsBody?.categoryBitMask = selectedAbducteeCategory
        selectedAbductee?.physicsBody?.contactTestBitMask = beamCategory
    }
    
    override func willMove(from view: SKView) {
        gameTimer.invalidate()
    }
    
    //game actions that run every second
    func runGameTimer() {
        
        cloakAlienShip()
        
        if currNumberOfAbductees < maxABInView {
            setNewAbductee()
        }

        self.enumerateChildNodes(withName: "Abductee") {
            node, stop in
            
            let ab = node as! Abductee
            if !ab.isSelected{
                ab.walk()
            }
            
        }

    }
    
    func setNewAbductee() {
        
        let ab = Abductee(texture: SKTexture(imageNamed: "man1.png"), color: .white, size: char1Size, points: 1200, mass: 500)
        //let ab = SKSpriteNode(imageNamed: "man1.png")
        ab.position = getRandomABPosition()
        addChild(ab)
        
        currNumberOfAbductees += 1
    }
    
    func removeOffScreenObjects() {
        
        self.enumerateChildNodes(withName: "Abductee") {
            node, stop in
            
            //remove those that have moved off screen
            if node.position.x < 0.0 || node.position.x > deviceWidth {
                node.removeAllActions()
                node.removeFromParent()
                self.currNumberOfAbductees -= 1

            }
        }
        
    }
    
    func attemptAbduction() {
        
        let oldPosition = selectedAbductee?.position
        let oldPositionX = selectedAbductee?.position.x
        let oldPositionY = selectedAbductee?.position.y
        var newX:CGFloat!
        let newY:CGFloat = oldPositionY! + abductionRateY
        
//        if oldPositionY == (tractorBeam?.position.y)! {
//            
//        }
//        
//        if oldPositionX != (tractorBeam?.position.x)! {
//            
//        }
        
        if (tractorBeam?.contains(oldPosition!))! {
            newX = (tractorBeam?.position.x)!
            //move selectedAbductee towards the ship with every tap
            selectedAbductee?.position = CGPoint(x: newX, y: newY)
        }
        else{
            removeTractorBeam()
        }
        
        //if abductee is within short distance of alien ship, call completeAbduction()
        
    }
    
    func releaseAbductee() {
        
        self.enumerateChildNodes(withName: "Abductee") {
            node, stop in
            
            let ab = node as! Abductee
            if ab.isSelected {

                ab.isSelected = false
                self.abducteeWasSelected = false
                print("Abductee was released")
                ab.run(SKAction.move(to: CGPoint(x: ab.position.x, y: characterStartingY), duration: 1.0))
            }
            
        }
        selectedAbductee = nil

    }
    
    func completeAbduction() {
        
        selectedAbductee = nil
        removeTractorBeam()
    }
    
    func setTractorBeam(abPosition: CGPoint) {
        //only create new tractor beam if one does not already exist
        tractorBeamInUse = true
        if tractorBeam != nil {
            tractorBeam?.removeFromParent()
            tractorBeam = nil
        }
        
        //get position of alien ship and position of selected abductee
        tractorBeam = TractorBeam(shipPosition: alienShip.position, abPosition: abPosition)
        
        //add tractor beam to view
        addChild(tractorBeam!)
        
    }
    
    func removeTractorBeam() {
        tractorBeam?.removeFromParent()
        tractorBeam = nil
        tractorBeamInUse = false
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
    
    func setButtons() {
        
    }
    
    //begin physics contact
    func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        // 2
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        //let contactPoint:CGPoint = contact.contactPoint
        
        if firstBody.categoryBitMask == selectedAbducteeCategory && secondBody.categoryBitMask == beamCategory {
            print("tractor beam touching abductee")
            abducteeIsInBeam = true
        }
        if firstBody.categoryBitMask == abducteeCategory && secondBody.categoryBitMask == abducteeCategory{
            //print("abductee touching abductee")
        }
    }
    
    //physics contact ended
    func didEnd(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        // 2
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == selectedAbducteeCategory && secondBody.categoryBitMask == beamCategory {
            
            print("tractor beam stopped touching abductee")
            abducteeIsInBeam = false
            releaseAbductee()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            
            if backButton.contains(location) {
                //go back to main menu
                
            }
            
            var abducteeTouched = false
            self.enumerateChildNodes(withName: "Abductee") {
                node, stop in
                
                let ab = node as! Abductee
                if ab.contains(location) {
                    //set tractor beam
                    self.selectedAbductee = ab
                    ab.isSelected = true
                    self.abducteeWasSelected = true
                    self.setTractorBeam(abPosition: ab.position)
                    print("Abductee was selected")
                    abducteeTouched = true
                }
                
            }
            
            //check to see if user is tapping empty space to abduct target
            if abducteeTouched == false && !backButton.contains(location){
                print("player tapped screen")
                
                if tractorBeamInUse && abducteeWasSelected {
                    attemptAbduction()
                }
                
            }
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        //continuously check to if selectedAbductee is in the tractor beam
        if tractorBeamInUse && (tractorBeam?.contains((selectedAbductee?.position)!))!{
            
            abducteeIsInBeam = true
            //consume energy from power meter
            
        }else {
            abducteeIsInBeam = false
            removeTractorBeam()
            releaseAbductee()
        }
        
        removeOffScreenObjects()
    }
}
