//
//  GameView.swift
//  swift2048
//
//  Created by jack on 10/7/17.
//  Copyright © 2017 jack. All rights reserved.
//

import UIKit

class GameView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        drawBackground()
        drawTiles()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Please no NSCoder inits")
    }
    
    fileprivate func drawBackground() {
        let bg = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width))
        bg.backgroundColor = UIColor.boardColor
        bg.layer.cornerRadius = 5
        self.addSubview(bg)
    }

    fileprivate func drawTiles() {
        let padding: CGFloat = 6
        let sideLength = (self.bounds.width - 5*padding) / 4
        var xCursor = padding
        var yCursor = padding

        for _ in 0 ..< 4 {
            xCursor = padding
            for _ in 0 ..< 4 {
                let tile = UIView(frame: CGRect(x: xCursor, y: yCursor, width: sideLength, height: sideLength))
                tile.backgroundColor = UIColor.tileColor
                tile.layer.cornerRadius = 4
                addSubview(tile)
                print(tile.debugDescription)
                xCursor += padding + sideLength
            }
            yCursor += padding + sideLength
        }
    }
}
