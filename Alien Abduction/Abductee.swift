//
//  Abductee.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/11/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

//texture, color, size, points, mass
let ab1: [Any] = ["man1.png", UIColor.white, char1Size, 125, 1]
let ab2: [Any] = ["man2.png", UIColor.white, char1Size, 250, 2]
let ab3: [Any] = ["man3.png", UIColor.white, char1Size, 375, 3]
let ab4: [Any] = ["man4.png", UIColor.white, char1Size, 550, 4]
let ab5: [Any] = ["man3.png", UIColor.white, char1Size, 650, 5]
let ab6: [Any] = ["man2.png", UIColor.white, char1Size, 50, 6]

let possibleAbductees = [ab1,ab2,ab3,ab4,ab5,ab6]

class Abductee: SKSpriteNode {
    
    var points:Int = 0
    var mass:Int = 0
    var direction: Direction!
    var isSelected = false
    
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
        self.physicsBody?.contactTestBitMask = beamCategory
        self.physicsBody?.collisionBitMask = otherCategory

        
    }
    
    func addPointsBubble() {
        
        let bubble = SKShapeNode(ellipseOf: CGSize(width: char1Size.width, height: char1Size.width * 0.5))
        bubble.fillColor = custBlue
        bubble.position = CGPoint(x: self.position.x, y: self.position.y + (self.size.height * 0.75))
        self.addChild(bubble)
        
        let pb = SKLabelNode(text: String(points))
        let fSize:CGFloat = 14.0
        pb.position = CGPoint(x: 0.0, y: 0.0 - fSize/3)
        pb.fontName = "AmericanTypewriter-Bold"
        pb.fontSize = fSize
        pb.fontColor = custRed
        bubble.addChild(pb)
    }
    
    func setUpright() {
        //reset abductee after they have fallen
        
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
