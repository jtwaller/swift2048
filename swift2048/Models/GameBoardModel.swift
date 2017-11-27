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
    func updateGameBoard()
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
    
    var board: [[Int]]
    unowned let delegate: GameBoardDelegate
    let allowedDirections: [UISwipeGestureRecognizerDirection] = [.up, .down, .left, .right]
    
    init(delegate: GameBoardDelegate) {
        board = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        self.delegate = delegate
        super.init()
        startGame()
        print(debugBoardString)
    }
    
    func startGame() {
        // New game starts with two randomly spawned tiles
        addNewTile()
        addNewTile()

        delegate.updateGameBoard()
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
    
    func handleSwipe(_ direction: UISwipeGestureRecognizerDirection) {
        
        print(debugBoardString + "\n\n")
        switch direction {
        case .left:
            for i in 0 ..< 4 {
                var curVector = Array(repeating: 0, count: 4)
                for j in 0 ..< 4 {
                    curVector[j] = board[i][j]
                }
                curVector = collapseVector(curVector)
                for j in 0 ..< 4 {
                    board[i][j] = curVector[j]
                }
            }
        case .right:
            for i in 0 ..< 4 {
                var curVector = Array(repeating: 0, count: 4)
                for j in (0 ..< 4) {
                    curVector[j] = board[i][3-j]
                }
                curVector = collapseVector(curVector)
                for j in (0 ..< 4).reversed() {
                    board[i][3-j] = curVector[j]
                }
            }
        case .up:
            for j in 0 ..< 4 {
                var curVector = Array(repeating: 0, count: 4)
                for i in 0 ..< 4 {
                    curVector[i] = board[i][j]
                }
                curVector = collapseVector(curVector)
                for i in 0 ..< 4 {
                    board[i][j] = curVector[i]
                }
            }
        case .down:
            for j in 0 ..< 4 {
                var curVector = Array(repeating: 0, count: 4)
                for i in (0 ..< 4) {
                    curVector[i] = board[3-i][j]
                }
                curVector = collapseVector(curVector)
                for i in (0 ..< 4) {
                    board[3-i][j] = curVector[i]
                }
            }
        default:
            print(direction.rawValue)
//            assert(false, "invalid swipe direction")
        }
        
        print(debugBoardString + "\n\n")
        
        addNewTile()
        delegate.updateGameBoard()
    }
    
    func collapseVector(_ input: [Int]) -> [Int] {
        var result = input
        
        // merge adjacent non-zero numbers
        for i in 0 ..< input.count - 1 {
            if result[i] == 0 {
                continue
            }
            for j in i + 1 ..< input.count {
                if result[j] != 0 && result[j] != result[i] {
                    break
                }
                
                if result[j] == result[i] {
                    result[i] = 2 * result[i]
                    result[j] = 0
                    break
                }
            }
        }
        print(result)
        
        // condense vector
        for lead in 0 ..< input.count - 1 {
            if result[lead] != 0 {
                continue
            }
            for follow in lead+1 ..< input.count {
                if result[follow] != 0 {
                    result[lead] = result[follow]
                    result[follow] = 0
                    break
                }
            }
        }
        
        return result
    }
    
    func getEmptyTiles() -> [TileCoords] {
        var result = [TileCoords]()
        let dimension = board.count
        for i in 0 ..< dimension {
            for j in 0 ..< dimension {
                if board[i][j] == 0 {
                    result.append(TileCoords(x: i, y: j))
                }
            }
        }
        return result
    }
    
    func newTileValue() -> Int {
        let fourTileSpawnrate = 10
        return (Int(arc4random_uniform(100)) >= fourTileSpawnrate) ? 2 : 4
    }
    
    func addNewTile() {
        let emptyTiles = getEmptyTiles()
        
        if emptyTiles.count == 0 {
            print("Game over")
            return
        }
        
        let coords = emptyTiles[Int(arc4random_uniform(UInt32(emptyTiles.count)))]
        board[coords.x][coords.y] = newTileValue()
        
        // TODO:  At end of addNewTile, if no valid moves, end game
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        startGame()
    }
}
