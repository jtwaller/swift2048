//
//  GameViewController.swift
//  swift2048
//
//  Created by jack on 9/27/17.
//  Copyright © 2017 jack. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, GameBoardDelegate {
    
    var gameBoardView: GameBoardView?
    var gameModel: GameBoardModel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        let padding: CGFloat = 6
        let boardLength = self.view.frame.width - 2 * padding
        let frame = CGRect(x: padding, y: self.view.frame.height - boardLength - 60.0, width: boardLength, height: boardLength)
        gameModel = GameBoardModel(delegate: self)
        gameBoardView = GameBoardView(frame: frame)
        self.view.addSubview(gameBoardView!)
        updateGameBoard()
        
        for direction in gameModel!.allowedDirections {
            let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gestureRecognizer.direction = direction
            self.view.addGestureRecognizer(gestureRecognizer)
        }
        
        // DEBUG STUFF
        
        let button = UIButton(frame: CGRect(x: 200, y: 50, width: 100, height: 50))
        button.setTitle("Do the thing", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(debugButtonAction), for: .touchUpInside)
        
        let button2 = UIButton(frame: CGRect(x: 200, y: 100, width: 150, height: 10))
        button2.setTitle("Do the other thing", for: .normal)
        button2.setTitleColor(UIColor.black, for: .normal)
        button2.addTarget(self, action: #selector(debugButtonAction2), for: .touchUpInside)
        
        self.view.addSubview(button)
        self.view.addSubview(button2)
    }
    
    func updateGameBoard() {
        for i in 0 ..< 4 {
            for j in  0 ..< 4 {
                gameBoardView?.tiles[i][j].value = gameModel!.board[i][j]
            }
        }
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            gameModel?.handleSwipe(sender.direction)
        }
    }
    
    @objc func debugButtonAction() {
        gameModel!.addNewTile()
        updateGameBoard()
    }
    
    @objc func debugButtonAction2() {
        gameModel!.resetGame()
    }
    
}
