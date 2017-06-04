//
//  vehicle.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/29/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit


class Vehicle: SKSpriteNode {
    
    var isSelected = false
    
    
    init(texture: SKTexture?, size: CGSize) {
        super.init(texture: texture, color: .white, size: size)
        
        self.texture = texture
        self.size = size
        self.name = "Item"
        
        self.zPosition = itemZPosition
        
        
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
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

