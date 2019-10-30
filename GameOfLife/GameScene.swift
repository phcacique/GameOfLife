//
//  GameScene.swift
//  GameOfLife
//
//  Created by Pedro Cacique on 29/10/19.
//  Copyright © 2019 Pedro Cacique. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var grid: Grid
    var cellSize:CGFloat = 20.0
    var isPlaying:Bool = false
    var countPlay:Int = 0

    override init( size: CGSize ) {
        
        self.grid = Grid(width: Int( size.width / cellSize ), height: Int(size.height / cellSize ))
        self.grid.addRule(CountRule(name: "Solitude", startState: .alive, endState: .dead, count: 2, type: .lessThan))
        self.grid.addRule(CountRule(name: "Survive2", startState: .alive, endState: .alive, count: 2, type: .equals))
        self.grid.addRule(CountRule(name: "Survive3", startState: .alive, endState: .alive, count: 3, type: .equals))
        self.grid.addRule(CountRule(name: "Overpopulation", startState: .alive, endState: .dead, count: 3, type: .greaterThan))
        self.grid.addRule(CountRule(name: "Birth", startState: .dead, endState: .alive, count: 3, type: .equals))
        
        super.init(size: CGSize(width: size.width, height: size.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - INPUT
    //--- Methods for the TouchBar ---
    func clear(){
        grid.clear()
    }
    
    func nextGen(){
        grid.applyRules()
    }
    
    func play(){
        self.isPlaying = true
    }
    
    func pause(){
        self.isPlaying = false
        self.countPlay = 0
    }
    //--------------------------------
    
    //--- mouse input ---
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let i = Int(pos.x / cellSize)
        let j = Int(pos.y / cellSize)
        let currentState = grid.getCellState(i: i, j: j )
        grid.setCellState(i: i, j: j, state: (currentState == .dead) ? .alive : .dead)
    }
    //-------------------
    
    //MARK: - UPDATE
    override func update(_ currentTime: TimeInterval) {
        //Update from Game Loop pattern
        if self.isPlaying && self.countPlay % 60 == 0{
            nextGen()
        }
        
        //Render from Game Loop pattern
        render()
    }

    
    //MARK: - RENDER
    func render(){
        self.removeAllChildren()
        self.backgroundColor = Theme.Colors.bgColor
        
        for i in 0..<grid.width{
            for j in 0..<grid.height{
                let currentState = grid.getCellState(i: i, j: j )
                let node = SKShapeNode(rect: CGRect(x: CGFloat(i) * cellSize , y:  CGFloat(j) * cellSize, width: cellSize, height: cellSize))
                node.strokeColor = (currentState == .dead) ? Theme.Colors.gridColor : Theme.Colors.bgColor
                node.fillColor = (currentState == .dead) ? Theme.Colors.bgColor : Theme.Colors.cellColor
                node.lineWidth = 0.5
                node.isAntialiased = false
                self.addChild(node)
            }
        }
    }
    
}
