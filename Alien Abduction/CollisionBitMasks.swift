//
//  ContactBitMasks.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/12/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

//collision bitmasks

let abducteeCategory:UInt32 = 0x1 << 0
let selectedAbducteeCategory:UInt32 = 0x1 << 1
let beamCategory:    UInt32 = 0x1 << 2
let otherCategory:   UInt32 = 0x1 << 3
let shipCategory:    UInt32 = 0x1 << 4
