//
//  GameViewController.swift
//  swift2048
//
//  Created by jack on 9/27/17.
//  Copyright © 2017 jack. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        let padding: CGFloat = 6
        let boardLength = self.view.frame.width - 2 * padding
        let frame = CGRect(x: padding, y: self.view.frame.height - boardLength - 60.0, width: boardLength, height: boardLength)
        let gameBoard = GameView(frame: frame)
        self.view.addSubview(gameBoard)
    }
    
    func setupGame() {
        let vcHeight = view.bounds.size.height
        let vcWidth = view.bounds.size.width
        
        let tileDimension = (vcWidth - 20) / 4

        print(vcHeight)
        print(vcWidth)
        print(tileDimension)
        
        var xCursor: CGFloat = 10.0
        var yCursor: CGFloat = 0.0
        
        // 4x4 gameboard
        let dimensions = 4
        
        for _ in 0 ..< dimensions {
            yCursor = 150
            for _ in 0 ..< dimensions {
                let background = UIView(frame: CGRect(x: xCursor, y: yCursor, width: tileDimension, height: tileDimension))
                let xMultiplier = (4 * tileDimension - xCursor) / (4 * tileDimension)
                let yMultiplier = (4 * tileDimension - yCursor + 150) / (4 * tileDimension)
                background.backgroundColor = UIColor(red: xMultiplier, green: yMultiplier, blue: 0, alpha: 1)
                view.addSubview(background)
                yCursor += tileDimension
            }
            xCursor += tileDimension
        }
        
    }
}
