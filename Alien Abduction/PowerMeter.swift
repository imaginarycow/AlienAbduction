//
//  PowerMeter.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/11/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

class PowerMeter: SKNode {
    
    var percentLabel:SKLabelNode!
    var powerLevel: CGFloat = 100
    
    let meterHeight = deviceHeight * 0.05
    let meterWidth = deviceHeight * 0.1
    
    var bars:[SKShapeNode] = []
    
    override init() {
       super.init()
        
        let outerShell = SKShapeNode(rectOf: CGSize(width: meterWidth, height: meterHeight), cornerRadius: 5.0)
        outerShell.lineWidth = 5
        outerShell.strokeColor = .black
        outerShell.fillColor = .black
        addChild(outerShell)
        
        percentLabel = SKLabelNode(text: "\(self.powerLevel)%")
        percentLabel.position = CGPoint(x: outerShell.position.x, y: outerShell.position.y  - meterHeight * 2)
        //percentLabel.fontName = inGameFont
        percentLabel.fontSize = 20.0
        percentLabel.fontColor = .red
        addChild(percentLabel)
        
        self.zPosition = bgZPosition + 1
        
        drawBars()
        
    }
    
    func drawBars() {
        
        bars = []
        
        let innerHeight = meterHeight * 0.9
        let innerWidth = meterWidth * 0.9
        let barWidth = innerWidth/6
        let spacing = barWidth + barWidth/4
        let startX = 0.0 - innerWidth/2 + barWidth/2

        
        for i in 0...4 {
            
            let bar = SKShapeNode(rectOf: CGSize(width: barWidth, height: innerHeight), cornerRadius: 0.0)
            bar.strokeColor = .clear
            bar.fillColor = powerLevel > 40 ? .green : .red
            bar.position = CGPoint(x: startX + (CGFloat(i) * spacing), y: self.position.y)
            bar.name = "bar\(i)"
            addChild(bar)
            
            bars.append(bar)
        }
    }
    
    func updateBars() {
        
        for bar in bars {
            
            if self.powerLevel <= 100 {
                bar.fillColor = .green
            }
            
            if self.powerLevel < 71 {
                bar.fillColor = .yellow
                
                if bar.name == "bar0" {
                    bar.fillColor = .black
                }
            }
            
            if self.powerLevel < 51 {
                bar.fillColor = .yellow
                
                if bar.name == "bar0" || bar.name == "bar1" {
                    bar.fillColor = .black
                }
                
            }
            
            if self.powerLevel < 31 {
                bar.fillColor = .red
                
                if bar.name == "bar0" || bar.name == "bar1" || bar.name == "bar2" {
                    bar.fillColor = .black
                }
                
            }
            
            if self.powerLevel < 11 {
                bar.fillColor = .red
                
                if bar.name == "bar0" || bar.name == "bar1" || bar.name == "bar2" || bar.name == "bar3" {
                    bar.fillColor = .black
                }
                
            }
            
            if self.powerLevel == 0 {
                bar.fillColor = .red
                bar.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5),SKAction.fadeIn(withDuration: 0.5)])))
                
            }

        }
    }
    
    func updatePowerMeter(powerGainOrLoss: CGFloat) {
        
        self.powerLevel += powerGainOrLoss
        
        if self.powerLevel > 120 {
            self.powerLevel = 120
        }
        if self.powerLevel < 0 {
            self.powerLevel = 0
        }
        
        self.percentLabel.text = "\(self.powerLevel)%"
        self.updateBars()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
