//
//  vehicle.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/29/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

let vehicleSize = CGSize(width: 150.0, height: 75.0)

class Vehicle: SKSpriteNode {
    
    var isSelected = false
    
    
    init(texture: SKTexture? = SKTexture(imageNamed: "vehicle1Left.png"), size: CGSize = vehicleSize) {
        super.init(texture: texture, color: .white, size: size)
        
        self.texture = texture
        self.size = size
        self.name = "Vehicle"
        
        self.zPosition = vehicleZPosition
        
        
        //physics setup
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = abducteeCategory
        self.physicsBody?.contactTestBitMask = beamCategory
        self.physicsBody?.collisionBitMask = otherCategory
        
        
    }
    
    func addPointsBubble() {
        
        //        let bubble = SKShapeNode(ellipseOf: CGSize(width: char1Size.width, height: char1Size.width * 0.5))
        //        bubble.fillColor = custBlue
        //        bubble.position = CGPoint(x: self.position.x, y: self.position.y + (self.size.height * 0.75))
        //        self.addChild(bubble)
        //
        //        let pb = SKLabelNode(text: String(points))
        //        let fSize:CGFloat = 14.0
        //        pb.position = CGPoint(x: 0.0, y: 0.0 - fSize/3)
        //        pb.fontName = "AmericanTypewriter-Bold"
        //        pb.fontSize = fSize
        //        pb.fontColor = custRed
        //        bubble.addChild(pb)
    }
    
    func drive() {
        //check which direction to drive
        self.run(SKAction.moveBy(x: -25.0, y: 0.0, duration: 1.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

