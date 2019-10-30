//
//  MainWindowController.swift
//  GameOfLife
//
//  Created by Pedro Cacique on 29/10/19.
//  Copyright © 2019 Pedro Cacique. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var buttonPlay: NSButton!
    @IBOutlet weak var buttonClear: NSButton!
    @IBOutlet weak var buttonNextGen: NSButton!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        buttonPlay.bezelColor = Theme.Colors.playButtonColor
    }

    @IBAction func playTapped(_ sender: Any) {
        if let scene = (contentViewController as! ViewController).scene {
            if !scene.isPlaying {
                scene.play()
                buttonPlay.title = "􀊆"
                buttonPlay.bezelColor = Theme.Colors.pauseButtonColor
            } else {
                scene.pause()
                buttonPlay.title = "􀊄"
                buttonPlay.bezelColor = Theme.Colors.playButtonColor
            }
        }
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        if let scene = (contentViewController as! ViewController).scene {
            scene.clear()
        }
    }
    
    @IBAction func nextgenTapped(_ sender: Any) {
        if let scene = (contentViewController as! ViewController).scene {
            scene.nextGen()
        }
    }
}
