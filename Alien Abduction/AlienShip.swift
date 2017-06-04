//
//  AlienShip.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/28/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

let shipSize = CGSize(width: 400, height: 200)

class AlienShip: SKSpriteNode {
    
    var lights:[SKShapeNode] = []
    
    init() {
        super.init(texture: SKTexture(imageNamed: "alienShipBody2.png"), color: .white, size: shipSize)
        
        self.texture = texture
        self.color = color
        self.size = size
        self.name = "AlienShip"
        self.zPosition = shipZPosition + 1
        
        let shipBody2 = (SKSpriteNode(imageNamed: "alienShipBody1.png"))
        shipBody2.zPosition = shipZPosition
        shipBody2.size = shipSize
        self.addChild(shipBody2)
        
        let shipTop = SKSpriteNode(imageNamed: "alienShipTop.png")
        shipTop.size = shipSize
        self.addChild(shipTop)
        
        let shipBottom = SKSpriteNode(imageNamed: "alienShipBottom.png")
        shipBottom.size = shipSize
        self.addChild(shipBottom)
        
        addLights()
        
        self.physicsBody = SKPhysicsBody(texture: shipBottom.texture!, size: shipBottom.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = shipCategory
        self.physicsBody?.contactTestBitMask = abducteeCategory
        
    }
    
    func addLights() {
        
        let rad:CGFloat = 15.0
        let seperation = rad * 4
        
        for i in 0...4 {
            let light = SKShapeNode(circleOfRadius: rad)
            light.strokeColor = .clear
            light.fillColor = getRandomColor()
            light.zPosition = self.zPosition + 2
            
            switch i {
            case 0:
                light.position = CGPoint(x: 0.0, y: 0.0 - rad*2.5)
            case 1:
                light.position = CGPoint(x: 0.0 - (seperation * 1), y: 0.0 - rad*2)
            case 2:
                light.position = CGPoint(x: 0.0 - (seperation * 2), y: 0.0 - rad*1.25)
            case 3:
                light.position = CGPoint(x: 0.0 + (seperation * 1), y: 0.0 - rad*2)
            case 4:
                light.position = CGPoint(x: 0.0 + (seperation * 2), y: 0.0 - rad*1.25)
            default:
                light.position = CGPoint(x: 0.0 - (seperation * 1), y: 0.0 - rad)
            }
            
            lights.append(light)
            addChild(light)
        }
        
    }
    
    func flashLights() {
        for light in lights {
            light.fillColor = getRandomColor()
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
