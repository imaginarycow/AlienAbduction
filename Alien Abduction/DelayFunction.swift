//
//  DelayFunction.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/12/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import SpriteKit

func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}
