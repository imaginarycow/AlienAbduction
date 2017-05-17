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
    var possibleAbductees:[Abductee] = []
    var tractorBeam:TractorBeam?
    var lastTap:Date = Date()
    var currNumberOfAbductees = 0
    var riseRateX:CGFloat!
    var riseRateY:CGFloat!
    
    //level booleans
    var isCloaked: Bool = false
    var tractorBeamInUse:Bool = false
    var abducteeWasSelected:Bool = false
    var abducteeIsInBeam:Bool = false
    var abductionCompleted:Bool = false

    
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
        
        if currNumberOfAbductees < maxABInView {
            setNewAbductee()
        }

        self.enumerateChildNodes(withName: "Abductee") {
            node, stop in
            
            let ab = node as! Abductee
            if !ab.isSelected{
                if self.tractorBeamInUse {
                    ab.run()
                }else {
                    ab.walk()
                }
            }
            
        }

    }
    
    func checkSecondsBetweenTaps() {
        print("checking seconds between taps")

        let elapsed = Date().timeIntervalSince(lastTap)
        print("elapsed time since tap: \(elapsed)")
        
        if elapsed > 2 {

            removeTractorBeam()
            releaseAbductee()
        }
        
    }
    
    func countAbducteesInView() {
        
        var count = 0
        
        self.enumerateChildNodes(withName: "Abductee") {
            node, stop in
            
            count += 1
        }
        currNumberOfAbductees = count
    }
    
    func setNewAbductee() {
    
        let randAB = getRandomAbductee()
        let ab = Abductee(texture: SKTexture(imageNamed: randAB[0] as! String), color: randAB[1] as! UIColor, size: randAB[2] as! CGSize, points: randAB[3] as! Int, mass: randAB[4] as! Int)

        ab.position = getRandomABPosition()
        addChild(ab)

    }
    
    func removeOffScreenObjects() {
        
        self.enumerateChildNodes(withName: "Abductee") {
            node, stop in
            
            //remove those that have moved off screen
            if node.position.x < 0.0 || node.position.x > deviceWidth {
                node.removeAllActions()
                node.removeFromParent()

            }
        }
        
    }
    
    func attemptAbduction() {
        
        let abCurrPosition = selectedAbductee?.position
        
        
        var newX = abCurrPosition?.x
        let newY = (selectedAbductee?.position.y)! + riseRateY
        
        if newX! > alienShip.position.x {
            newX = (selectedAbductee?.position.x)! - riseRateX
        }
        if newX! < alienShip.position.x {
            newX = (selectedAbductee?.position.x)! + riseRateX
        }
        
        
        if (tractorBeam?.contains(abCurrPosition!))! || abducteeIsInBeam {
            
            //move selectedAbductee towards the ship with every tap
            selectedAbductee?.position = CGPoint(x: newX!, y: newY)
        }
        else{
            removeTractorBeam()
        }
        
        
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
        abductionCompleted = false

    }
    
    func completeAbduction() {
        
        abductionCompleted = false
        print("Abduction completed: \(abductionCompleted)")
        print("CompleteAbduction called")
        
        selectedAbductee = nil
        selectedAbductee?.removeFromParent()
        
        self.enumerateChildNodes(withName: "Abductee") {
            node, stop in
            
            let ab = node as! Abductee
            if ab.isSelected{
                ab.removeAllActions()
                ab.removeFromParent()
            }
            
        }
        
        removeTractorBeam()
        
        let spark = createParticle(target: alienShip)
        spark.numParticlesToEmit = 300
        alienShip.addChild(spark)
        
        delay(4.0) {
            spark.removeFromParent()
            spark.targetNode = nil
            spark.resetSimulation()
            
        }
        //reset tap time stamp array
        releaseAbductee()
    }
    
    func setTractorBeam(abPosition: CGPoint) {
        abductionCompleted = false
        
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
        
        //set rise and run for abduction
        let abCurrPosition = selectedAbductee?.position
        let abCurrX = abCurrPosition?.x
        let abCurrY = abCurrPosition?.y
        
        let heightToGo:CGFloat = alienShip.position.y - abCurrY!
        var widthToGo:CGFloat = 0
        
        if abCurrX! > alienShip.position.x {
            widthToGo = abCurrX! - alienShip.position.x
        }
        if abCurrX! < alienShip.position.x {
            widthToGo = alienShip.position.x - abCurrX!
        }

        riseRateX = widthToGo/(minNumberOfTaps * CGFloat((selectedAbductee?.mass)!))
        riseRateY = heightToGo/(minNumberOfTaps * CGFloat((selectedAbductee?.mass)!))
        
    }
    
    func removeTractorBeam() {
        tractorBeam?.removeFromParent()
        tractorBeam = nil
        tractorBeamInUse = false
        abductionCompleted = false
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
    
    func swerveAlienShip() {
        
        let randomNumber = getRandomNumber(max: 10)
        
        if randomNumber % 2 == 0 {
            alienShip.run(SKAction.moveBy(x: 80.0, y: -80.0, duration: 0.3))
            delay(1.0, completion: {
                self.alienShip.run(SKAction.move(to: shipPosition, duration: 0.3))
            })
        }else {
            
            alienShip.run(SKAction.moveBy(x: -80.0, y: -80.0, duration: 0.3))
            delay(1.0, completion: {
                self.alienShip.run(SKAction.move(to: shipPosition, duration: 0.3))
            })

        }
    }
    
    func setAlienShip() {
        alienShip.zPosition = shipZPosition
        alienShip.position = shipPosition
        alienShip.physicsBody = SKPhysicsBody(texture: alienShip.texture!, size: alienShip.size)
        alienShip.physicsBody?.affectedByGravity = false
        alienShip.physicsBody?.isDynamic = false
        alienShip.physicsBody?.categoryBitMask = shipCategory
        alienShip.physicsBody?.contactTestBitMask = abducteeCategory
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
        if firstBody.categoryBitMask == abducteeCategory && secondBody.categoryBitMask == shipCategory{
            print("abductee touching alien ship")
            print("Abduction completed: \(abductionCompleted)")
            if !abductionCompleted {
                completeAbduction()
                abductionCompleted = true
                print("Abduction completed: \(abductionCompleted)")
            }
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
        
        if firstBody.categoryBitMask == abducteeCategory && secondBody.categoryBitMask == shipCategory {
            
            print("abductee stopped touching ship")
            abducteeIsInBeam = false
            //releaseAbductee()
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
            
            if alienShip.contains(location) {
                //Play alien voice & swerve ship
                swerveAlienShip()
            }
            
            var abducteeTouched = false
            self.enumerateChildNodes(withName: "Abductee") {
                node, stop in
                
                let ab = node as! Abductee
                if ab.contains(location) {
                    //set tractor beam
                    self.selectedAbductee = ab
//                    self.selectedAbductee?.physicsBody?.categoryBitMask = selectedAbducteeCategory
//                    self.selectedAbductee?.physicsBody?.contactTestBitMask = beamCategory
                    ab.isSelected = true
                    self.abducteeWasSelected = true
                    self.setTractorBeam(abPosition: ab.position)
                    print("Abductee was selected")
                    abducteeTouched = true
                    self.lastTap = Date()
                }
                
            }
            
            //check to see if user is tapping empty space to abduct target
            if abducteeTouched == false && !backButton.contains(location){
                print("player tapped screen")
                
                if tractorBeamInUse && abducteeWasSelected {
                    attemptAbduction()
                    lastTap = Date()

                }
                
            }
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if tractorBeamInUse {
            checkSecondsBetweenTaps()
        }
        
        
        //check how many abductees in view at all times
        countAbducteesInView()

        //continuously check to if selectedAbductee is in the tractor beam
        if tractorBeamInUse && (tractorBeam?.contains((selectedAbductee?.position)!))!{
            
            abducteeIsInBeam = true
            //consume energy from power meter
            
        }else {
            abducteeIsInBeam = false
            //removeTractorBeam()
            //releaseAbductee()
        }
        
        removeOffScreenObjects()
    }
}
