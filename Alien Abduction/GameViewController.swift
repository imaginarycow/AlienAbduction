//
//  GameViewController.swift
//  Alien Abduction
//
//  Created by Ramiro Beltran on 5/11/17.
//  Copyright © 2017 Ramiro Beltran. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene: SKScene!
    var thisView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene = GameScene()
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        deviceWidth = skView.bounds.size.width
        deviceHeight = skView.bounds.size.height
        ratio = deviceWidth/deviceHeight
        thisView = skView
        
        setScale()
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .aspectFill
        scene.size = skView.bounds.size
        
        skView.presentScene(scene)
        
        //printFonts()
        
    }
    
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        deviceWidth = thisView.bounds.size.width
        deviceHeight = thisView.bounds.size.height
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
