//
//  ParticleEmitters.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/14/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

let particle1 = Bundle.main.path(forResource: "ABCompleteParticleEmitter", ofType: "sks")
let abductionParticle1 = NSKeyedUnarchiver.unarchiveObject(withFile: particle1!) as! SKEmitterNode

func createParticle(target: SKNode) -> SKEmitterNode{
    
    abductionParticle1.removeFromParent()
    abductionParticle1.resetSimulation()
    
    let particle = abductionParticle1
    
//    particle.removeAllActions()
//    particle.removeFromParent()
//    particle.resetSimulation()
//    particle.targetNode = nil
    
    particle.resetSimulation()
    particle.targetNode = target
    particle.zPosition = particleZPosition
    
    return particle
    
}

