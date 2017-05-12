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
        self.zPosition = 5
        self.alpha = 0.5
        self.name = name
        
        let path = CGMutablePath()
        let startPoint = CGPoint(x: shipPosition.x, y: shipPosition.y)
        let midPoint1 = CGPoint(x: abPosition.x - 30.0, y: abPosition.y)
        let midPoint2 = CGPoint(x: abPosition.x + 30.0, y: abPosition.y)
        let endPoint = CGPoint(x: shipPosition.x, y: shipPosition.y)
        
        path.move(to: startPoint)
        path.addLine(to: midPoint1)
        path.addLine(to: midPoint2)
        //path.addCurve(to: endPoint, control1: midPoint1, control2: midPoint2)
        path.addLine(to: endPoint)
        
        
        self.path = path
        
        self.physicsBody?.mass = 1.0
        self.physicsBody = SKPhysicsBody(edgeChainFrom: path)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
