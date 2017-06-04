//
//  DialogBox.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/20/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

let dBoxSize = CGSize(width: deviceWidth * 0.25, height: deviceWidth * 0.16)

class DialogBox: SKNode {
    
    var text:String = ""
    
    init(text:String) {
        super.init()
        
        self.name = "DialogBox"
        self.text = text
    
        addMainBox()
        //addBubbles()
        
    }
    
    func addMainBox() {
        
        let bubble = SKShapeNode(rectOf: dBoxSize, cornerRadius: 40.0)
        bubble.fillColor = .clear
        bubble.strokeColor = .clear
        addChild(bubble)
        
        //break string apart into lines based on how wide the box is
        var string1 = ""
        var string2 = ""
        var string3 = ""
        var row = 0
        
        for char in text.characters {
            
            if char == "*" {
                //create a new line
                row += 1
                
            }else {
                if row == 0 {
                    string1 += String(char)
                }
                if row == 1 {
                    string2 += String(char)
                }
                if row == 2 {
                    string3 += String(char)
                }
                
            }
            
        }

        
        for row in 0...2 {
            
            let line = SKLabelNode()
            let fSize:CGFloat = 20.0
            line.fontColor = custBlue
            line.fontSize = fSize
            line.fontName = globalFont
            line.zPosition = bubble.zPosition + 1
            
            if row == 0 {
                line.text = string1
                line.position = CGPoint(x: 0.0, y: 0.0 + fSize)
            }
            if row == 1 {
                line.text = string2
                line.position = CGPoint(x: 0.0, y: 0.0)
            }
            if row == 2 {
                line.text = string3
                line.position = CGPoint(x: 0.0, y: 0.0 - fSize)
            }
            
            bubble.addChild(line)
            

        }

    }
    
    func addBubbles() {
        
        let rad = dBoxSize.height * 0.1
        let spacing:CGFloat = rad * 2
        
        let bubble1 = SKShapeNode(circleOfRadius: rad)
        bubble1.fillColor = .red
        bubble1.strokeColor = .red
        bubble1.position = CGPoint(x: 0.0, y: 0.0 - dBoxSize.height * 0.4)
        addChild(bubble1)
        
        
        let bubble2 = SKShapeNode(circleOfRadius: rad * 0.5)
        bubble2.position = CGPoint(x: 0.0, y: bubble1.position.y - spacing)
        bubble2.fillColor = .red
        bubble2.strokeColor = .red
        addChild(bubble2)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
