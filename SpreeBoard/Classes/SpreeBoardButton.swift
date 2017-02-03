//
//  SpreeBoardButton.swift
//  SpreeBoard
//
//  Created by Trevor Poppen on 8/19/16.
//  Copyright © 2016 Spreetail. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class SpreeBoardButton: UIButton {
    let text: String
    init(frame: CGRect, text: String) {
        self.text = text
        
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8.0;
        self.backgroundColor = Colors.SpreeBlue3
        self.setTitle(text, forState: UIControlState.Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}