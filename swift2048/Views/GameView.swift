//
//  GameView.swift
//  swift2048
//
//  Created by jack on 10/7/17.
//  Copyright © 2017 jack. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    var sideLength: CGFloat = 0
    let padding: CGFloat = 6
    var tiles: [[TileView]]

    override init(frame: CGRect) {
        tiles = [[TileView]]()
        super.init(frame: frame)
        sideLength = (self.bounds.width - 5*padding) / 4

        drawBoard()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Please no NSCoder inits")
    }

    fileprivate func drawBoard() {
        let bg = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width))
        bg.backgroundColor = UIColor.boardColor
        bg.layer.cornerRadius = 5
        self.addSubview(bg)
        
        var xCursor = padding
        var yCursor = padding
        
        for i in 0 ..< 4 {
            xCursor = padding
            tiles.append([TileView]())
            for j in 0 ..< 4 {
                tiles[i].append(TileView(frame: CGRect(x: xCursor, y: yCursor, width: sideLength, height: sideLength)))

                self.addSubview(tiles[i][j])
                xCursor += padding + sideLength
            }
            yCursor += padding + sideLength
        }
    }

    func drawTiles(_ tiles: [[Int]]) {
        // TODO OH BOY
        var xCursor = padding
        var yCursor = padding
        
        for i in 0 ..< 4 {
            xCursor = padding
            for j in 0 ..< 4 {
                let tile = UIView(frame: CGRect(x: xCursor, y: yCursor, width: sideLength, height: sideLength))
                tile.layer.cornerRadius = 4
                if tiles[i][j] != 0 {
                    tile.backgroundColor = UIColor.white
                } else {
                    tile.backgroundColor = UIColor.tileColor
                }
                
                self.addSubview(tile)
                xCursor += padding + sideLength
            }
            yCursor += padding + sideLength
        }
    }
    
    func clearBoard() {
//        self.subviews.forEach({ $0.removeFromSuperview() })
//        drawBoard()
    }
}
