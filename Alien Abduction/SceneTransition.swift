//
//  SceneTransition.swift
//  Audio Profile
//
//  Created by Ramiro Beltran on 4/23/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

func transitionScene(nextScene: SKScene, currScene: SKScene) {
    
    //let transition = SKTransition.reveal(with: .down, duration: 1.0)
    let transition = SKTransition.crossFade(withDuration: 1.0)
    
    let nxt = nextScene
    nextScene.size = currScene.size
    nextScene.scaleMode = currScene.scaleMode
    
    currScene.view?.presentScene(nxt, transition: transition)
}
