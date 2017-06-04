//
//  TextFormatter.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/20/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit


func formatText(size:CGSize,text: String) -> SKShapeNode{
    
    let textBox = SKShapeNode(rectOf: CGSize(width: size.width, height: size.height))
    textBox.fillColor = .clear
    
    let maxWidth = size.width * 0.8
    let maxCharsPerLine = maxWidth / 3
    var currCharIndex = 0
    
    //break string apart into lines based on how wide the box is
    let totalStringLength = text.characters.count
    
    for i in 0...2 {
        
        let thisLine = text
        let line = SKLabelNode(text: thisLine)
        let fSize:CGFloat = 18.0
        line.fontColor = .red
        line.fontSize = fSize
        line.fontName = globalFont
        line.zPosition = textBox.zPosition + 1
        
        if i == 0 {
            line.position = CGPoint(x: 0.0, y: 0.0 + fSize)
        }
        if i == 1 {
            line.position = CGPoint(x: 0.0, y: 0.0)
        }
        if i == 2 {
            line.position = CGPoint(x: 0.0, y: 0.0 - fSize)
        }
        
        textBox.addChild(line)
    }
    
    
    return textBox
}
