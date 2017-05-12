//
//  MenuScene.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/11/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .yellow
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            
//            if newProfileButton.contains(location) {
//                //go to new profile scene
//                transitionScene(nextScene: NewProfileScene(), currScene: self)
//            }
//            
//            if settingsButton.contains(location) {
//                //go back to menu Scene
//                transitionScene(nextScene: SettingsScene(), currScene: self)
//                
//            }
            
            
        }
    }


}
