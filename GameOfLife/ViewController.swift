//
//  ViewController.swift
//  GameOfLife
//
//  Created by Pedro Cacique on 29/10/19.
//  Copyright © 2019 Pedro Cacique. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    var scene:GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let view = self.skView {

            scene = GameScene(size: CGSize(width: self.view.visibleRect.width, height: self.view.visibleRect.height))
            
            scene?.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true

            
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }
    
}



