//
//  Abductee.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/11/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

class Abductee: SKSpriteNode {
    
    var points:Int = 0
    var mass:Int = 0
    var direction: Direction!
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, points: Int, mass:Int) {
        super.init(texture: texture, color: color, size: size)
        
        self.texture = texture
        self.color = color
        self.size = size
        self.points = points
        self.mass = mass
        self.name = "Abductee"
        self.direction = getRandomDirection()
        self.zPosition = abducteeZPosition
        addPointsBubble()
        
        //physics setup
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = abducteeCategory
        self.physicsBody?.contactTestBitMask = beamCategory | abducteeCategory
        self.physicsBody?.collisionBitMask = otherCategory

        
    }
    
    func addPointsBubble() {
        
        let pb = SKLabelNode(text: String(points))
        pb.position = CGPoint(x: self.position.x, y: self.position.y + (self.size.height * 0.6))
        pb.fontName = "AmericanTypewriter-Bold"
        pb.fontSize = 14.0
        pb.fontColor = .red
        self.addChild(pb)
    }
    
    func walk() {
        if self.direction == .Left {
            self.run(SKAction.moveBy(x: -charWalkSpeed, y: 0.0, duration: 1.0))
        }else {
            self.run(SKAction.moveBy(x: charWalkSpeed, y: 0.0, duration: 1.0))
        }
        
    }
    
    func run() {
        if self.direction == .Left {
            self.run(SKAction.moveBy(x: -charRunSpeed, y: 0.0, duration: 1.0))
        }else {
            self.run(SKAction.moveBy(x: charRunSpeed, y: 0.0, duration: 1.0))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
