//
//  TileView.swift
//  swift2048
//
//  Created by jack on 10/14/17.
//  Copyright © 2017 jack. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    var value: Int = 0 {
        didSet {
            updateColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.tileColor
        self.layer.cornerRadius = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("No coder init available for TileView")
    }
    
    fileprivate func updateColor() {
        // 2^12 = 4096
        let whiteValue = log2(Float(value)) / 12
        self.backgroundColor = UIColor(white: CGFloat(whiteValue), alpha: 1.0)
    }
    
}
