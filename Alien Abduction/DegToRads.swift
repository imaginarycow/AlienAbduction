//
//  DegToRads.swift
//  Audio Profile
//
//  Created by Ramiro Beltran on 4/23/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import Foundation

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
