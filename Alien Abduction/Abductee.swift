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
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, points: Int) {
        super.init(texture: texture, color: color, size: size)
        
        self.texture = texture
        self.color = color
        self.size = size
        self.points = points
        addPointsBubble()
        
    }
    
    func addPointsBubble() {
        let pb = SKLabelNode(text: String(points))
        pb.position = CGPoint(x: self.position.x, y: self.position.y + (self.size.height * 0.6))
        pb.fontName = "AmericanTypewriter-Bold"
        pb.fontSize = 14.0
        pb.fontColor = .red
        self.addChild(pb)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
