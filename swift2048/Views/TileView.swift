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
            updateNumber()
        }
    }
    var numberLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.tileColor
        self.layer.cornerRadius = 4
        
        let numberPadding: CGFloat = 10
        let numberDimension = self.frame.width - 2 * numberPadding
        numberLabel = UILabel(frame: CGRect(x: numberPadding, y: numberPadding, width: numberDimension, height: numberDimension))
        numberLabel!.textAlignment = .center
        numberLabel?.textColor = UIColor.white
        
        updateColor()
        
        self.addSubview(numberLabel!)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("No coder init available for TileView")
    }
    
    fileprivate func updateColor() {
        // 2^12 = 4096
        let whiteValue = (log2(Float(value)) > 0) ? log2(Float(value)) / 12 : 0
        self.backgroundColor = UIColor(white: CGFloat(whiteValue), alpha: 1.0)
    }
    
    fileprivate func updateNumber() {
        if self.value == 0 {
            numberLabel?.alpha = 0
        } else {
            numberLabel?.alpha = 1
        }
        
        numberLabel?.text = String(self.value)
    }
}
