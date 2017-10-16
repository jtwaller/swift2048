//
//  GameBoardModel.swift
//  swift2048
//
//  Created by jack on 10/8/17.
//  Copyright © 2017 jack. All rights reserved.
//

// GameBoardModel contains the game state and provides move orders to the view controller
// dev path: working game w/ no animations -> polish later!

import UIKit

protocol GameBoardDelegate: class {
    func updateGameBoard(tiles: [[Int]])
}

struct TileCoords {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func printCoords() {
        print("TileCoords: \(x), \(y)")
    }
}

class GameBoardModel: NSObject {
    
    var board = Array(repeating: Array(repeating: 0, count: 4), count: 4) {
        didSet {
//            delegate.updateGameBoard(tiles: board)
        }
    }
    
    unowned let delegate: GameBoardDelegate
    
    init(delegate: GameBoardDelegate) {
        self.delegate = delegate
        super.init()
        startGame()
        print(debugBoardString)
    }
    
    func startGame() {
        // New game starts with two randomly spawned tiles
        addNewTile()
        addNewTile()
    }
    
    func newTileValue() -> Int {
        let fourTileSpawnrate = 10
        return (Int(arc4random_uniform(100)) >= fourTileSpawnrate) ? 2 : 4
    }
    
    var debugBoardString: String {
        var result = ""
        for i in 0 ..< 4 {
            for j in 0 ..< 4 {
                result += String(board[i][j]) + " "
            }
            result += "\n"
        }
        return result
    }
    
    func addNewTile() {
        let emptyTiles = getEmptyTiles()
        
        if emptyTiles.count == 0 {
            print("Game over")
            return
        }
        
        let coords = emptyTiles[Int(arc4random_uniform(UInt32(emptyTiles.count)))]
        
        board[coords.x][coords.y] = newTileValue()
        delegate.updateGameBoard(tiles: board)
        
        // TODO:  At end of addNewTile, if no valid moves, end game
    }
    
    func getEmptyTiles() -> [TileCoords] {
        var result = [TileCoords]()
        let dimension = board.count
        for i in 0 ..< dimension {
            for j in 0 ..< dimension {
                if board[i][j] == 0 {
                    result.append(TileCoords(x: i, y: j))
                }
//                print("i \(i)   j \(j)  value: \(board[i][j])")
            }
        }
        
//        print(result.debugDescription)
//        print(result.count)
        
        return result
    }
    
    func resetGame() {
        for i in 0 ..< board.count {
            for j in 0 ..< board[i].count {
                board[i][j] = 0
            }
        }
        
        startGame()
    }
}
