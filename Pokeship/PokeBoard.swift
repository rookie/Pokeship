//
//  PokeBoard.swift
//  Pokeship
//
//  Created by Raghav Mangrola on 8/6/16.
//  Copyright © 2016 Neko Labs. All rights reserved.
//

import Foundation

class PokeBoard {
  
  enum GridState {
    case None
    case Close
    case Occupied
  }
  
  let columns: Int
  let rows: Int
  var grid: [[GridState]]
  var positions: [Position] = []

  init(columns: Int, rows: Int) {
    self.columns = columns
    self.rows = rows
    
    let rowCells = [GridState](count: columns, repeatedValue: GridState.None)
    
    grid = [[GridState]](count: rows, repeatedValue: rowCells)
    
  }
  
  func indexForPosition(position: Position) -> Int? {
    for index in 0..<positions.count {
      if positions[index].column == position.column &&
      positions[index].row == position.row {
        return index
      }
    }
    return nil
  }
  
  func stateForPosition(position: Position) -> GridState {
    return grid[position.row][position.column]
  }
  
  func getRandomPositions(count: Int) -> [Position] {
    
    positions.removeAll()
    
    var numberLeft = count
    
    while numberLeft > 0 {
      
      let randomRow = Int(arc4random_uniform(UInt32(rows)))
      let randomColumn = Int(arc4random_uniform(UInt32(columns)))
      
      print("Attempt to place: \(randomRow), \(randomColumn)")
      
      // Check if None
      if grid[randomRow][randomColumn] == .None {
        print("Success")
        // Place around
        for tempRow in (randomRow-1)...(randomRow+1) {
          for tempColumn in (randomColumn-1)...(randomColumn+1) {
            if tempRow < 0 || tempRow >= rows ||
              tempColumn < 0 || tempColumn >= columns{
              // Ignore
            } else {
              grid[tempRow][tempColumn] = .Close
            }
          }
        }
        
        // Place in grid
        grid[randomRow][randomColumn] = .Occupied
        
        
        // Add to saved position
        positions.append(Position(row: randomRow, column: randomColumn))
        
        // decrement
        numberLeft -= 1
      } else {
        print("Already taken")
        // If occupied o nothing
      }
      
    }
    return positions
  }
  
}