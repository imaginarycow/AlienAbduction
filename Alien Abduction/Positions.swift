//
//  Positions.swift
//  Audio Profile
//
//  Created by Ramiro Beltran on 4/23/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

var thisView: SKView!

var deviceWidth: CGFloat!
var deviceHeight: CGFloat!
var ratio:CGFloat!

var centerX: CGFloat = deviceWidth/2
var centerY: CGFloat = deviceHeight/2

var centerScreen = CGPoint(x: centerX, y: centerY)

let homeButtonPosition = CGPoint(x: deviceWidth * 0.1, y: deviceHeight * 0.9)

let characterStartingY = deviceHeight * 0.15
let vehicleStartingY = deviceHeight * 0.10

let shipPosition = CGPoint(x: centerX, y: deviceHeight * 0.85)
let shipPosition2 = CGPoint(x: centerX, y: deviceHeight * 0.825)
