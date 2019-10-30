//
//  Grid.swift
//  GameOfLife
//
//  Created by Pedro Cacique on 29/10/19.
//  Copyright © 2019 Pedro Cacique. All rights reserved.
//

import Foundation

class Grid{
    var width:Int
    var height:Int
    var cells: [[Cell]]
    var rules: [Rule] = []
    
    init(width:Int = 10, height:Int = 10) {
        self.width = width
        self.height = height
        self.cells = []
        
        initEmptyGrid(width, height)
    }
    
    func initEmptyGrid(_ width: Int, _ height: Int) {
        cells = []
        for i in 0..<width{
            var row:[Cell] = []
            for j in 0..<height{
                row.append(Cell(x: i, y: j , state: .dead))
            }
            cells.append(row)
        }
    }
    
    func getLiveNeighbors(cell:Cell) -> [Cell] {
        let i:Int = cell.x
        let j:Int = cell.y
        let state:CellState = .alive
        var neighbors:[Cell] = []
        //line above
        if j>0 {
            if i>0 && self.cells[i-1][j-1].state == state{
                    neighbors.append(self.cells[i-1][j-1])
            }
            if self.cells[i][j-1].state == state{
                neighbors.append(self.cells[i][j-1])
            }
            if i<self.width-1 && self.cells[i+1][j-1].state == state {
                neighbors.append(self.cells[i+1][j-1])
            }
        }
        
        //current line
        if i>0 && cells[i-1][j].state == state {
            neighbors.append(self.cells[i-1][j])
        }
        if i<self.width-1 && self.cells[i+1][j].state == state {
            neighbors.append(self.cells[i+1][j])
        }
        
        //line beyond
        if j<self.height-1 {
            if i>0 && self.cells[i-1][j+1].state == state {
                neighbors.append(self.cells[i-1][j+1])
            }
            if self.cells[i][j+1].state == state {
                neighbors.append(self.cells[i][j+1])
            }
            if i<self.width-1 && self.cells[i+1][j+1].state == state {
                neighbors.append(self.cells[i+1][j+1])
            }
        }
        
        return neighbors
    }
    
    func getCellState(i:Int, j:Int) -> CellState{
        return self.cells[i][j].state
    }
    
    func setCellState(i:Int, j:Int, state:CellState){
        self.cells[i][j].state = state
    }
    
    func clear(){
        initEmptyGrid(self.width, self.height)
    }
    
    func addRule(_ rule:Rule){
        self.rules.append(rule)
    }
    
    func applyRules(){
        var newCells = cells
        for i in 0..<width{
            for j in 0..<height{
                let n:[Cell] = getLiveNeighbors(cell: cells[i][j])
                var newState:CellState = .dead

                //TODO: apply the rules using the array of rules (fix the applying method
//                for rule in rules {
//                    newState = rule.applyToNewCell(state: cells[i][j].state, neighbors: n)
//                }
                
                if cells[i][j].state == .dead && n.count == 3{
                    newState = .alive
                } else if cells[i][j].state == .alive && (n.count < 2 || n.count > 3) {
                    newState = .dead
                } else if cells[i][j].state == .alive && (n.count == 2 || n.count == 3) {
                    newState = .alive
                } else {
                    newState = .dead
                }
                newCells[i][j] = Cell(x: i, y: j, state: newState)
            }
        }
        cells = newCells
    }
}
