//
//  TractorBeam.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/11/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

class TractorBeam: SKShapeNode{
    
    
    init(shipPosition:CGPoint, abPosition:CGPoint) {
        super.init()
        
        self.lineWidth = 1
        self.strokeColor = .yellow
        self.fillColor = .yellow
        self.zPosition = beamZPosition
        self.alpha = 0.5
        self.name = name
        
        let path = CGMutablePath()
        let startPoint = CGPoint(x: shipPosition.x, y: shipPosition.y)
        let midPoint1 = CGPoint(x: abPosition.x - char1Size.width, y: abPosition.y - char1Size.height/2)
        let midPoint2 = CGPoint(x: abPosition.x + char1Size.width, y: abPosition.y - char1Size.height/2)
        let endPoint = CGPoint(x: shipPosition.x, y: shipPosition.y)
        
        path.move(to: startPoint)
        path.addLine(to: midPoint1)
        path.addLine(to: midPoint2)
        //path.addCurve(to: endPoint, control1: midPoint1, control2: midPoint2)
        path.addLine(to: endPoint)
        path.closeSubpath()
    
        self.path = path
        

        self.physicsBody = SKPhysicsBody(polygonFrom: (path))
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = beamCategory
        self.physicsBody?.contactTestBitMask = abducteeCategory
        self.physicsBody?.collisionBitMask = otherCategory

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
