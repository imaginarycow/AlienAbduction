//
//  RandomFunctions.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/12/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

func getRandomColor() -> UIColor {
    
    return colorsArray[getRandomNumber(max: colorsArray.count - 1)]
}

func getRandomAbductee() -> [Any] {
    
    return possibleAbductees[getRandomNumber(max: possibleAbductees.count - 1)]
}

func getRandomABPosition() -> CGPoint {
    
    return CGPoint(x: getRandomFloat(min: 0.5, max: deviceWidth), y: characterStartingY)
}

func getRandomDirection() -> Direction {
    
    let randomNumb = Int(arc4random_uniform(UInt32(10)))

    let direction:Direction = randomNumb % 2 == 0 ? .Left : .Right
    
    return direction
}

func getRandomFloat(min:CGFloat, max:CGFloat) ->CGFloat {
    
    return CGFloat(Int(arc4random_uniform(UInt32(max))))
    
}

func getRandomNumber(max:Int) ->Int {
    
    return Int(arc4random_uniform(UInt32(max)))

}
