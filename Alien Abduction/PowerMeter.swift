//
//  PowerMeter.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/11/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

class PowerMeter: SKNode {
    
    var powerLevel: CGFloat!
    
    override init() {
       super.init()
        
    }
    
    func updatePowerMeter(powerGainOrLoss: CGFloat) {
        
        //self.powerLevel += powerGainOrLoss
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
