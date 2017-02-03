//
//  SpreeBoard.swift
//  SpreeBoard
//
//  Created by Trevor Poppen on 8/19/16.
//  Copyright © 2016 Spreetail. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

public struct Colors {
    static let SpreeRed = UIColor(rgba: "#F45B5F")
    static let SpreeBlue1 = UIColor(rgba: "#1D4849")
    static let SpreeBlue2 = UIColor(rgba: "#2D6B70")
    static let SpreeBlue3 = UIColor(rgba: "#67D5C9")
    static let SpreeBlue4 = UIColor(rgba: "#8EF4D0")
}

public protocol SpreeBoardDelegate {
    func inputUpdated(input: String)
    func enter()
    func dismissKeyboard()
}

public enum SpreeBoardInputState {
    case Normal, NumPad
}

public class SpreeBoard: UIView {
    let delegate: SpreeBoardDelegate
    let numPad: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    let characters: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                                "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
                                   "A", "S", "D", "F", "G", "H", "J", "K", "L",
                                        "Z", "X", "C", "V", "B", "N", "M"]
    
    var inputString: String
    var inputState: SpreeBoardInputState
    
    public init(frame: CGRect, state: SpreeBoardInputState, delegate: SpreeBoardDelegate) {
        self.delegate = delegate
        self.inputString = ""
        self.inputState = state
        
        // setup the view
        super.init(frame: frame)
        self.backgroundColor = Colors.SpreeBlue1
        if self.inputState == .Normal {
            self.drawNormalKeyboard()
        } else if self.inputState == .NumPad {
            self.drawNumPad()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawNormalKeyboard() {
        self.subviews.forEach({ $0.removeFromSuperview() })
        
        // configure buttons
        let buttonWidth: CGFloat = self.frame.width * 0.09
        let bigButtonWidth: CGFloat = buttonWidth * 3
        let buttonHeight: CGFloat = self.frame.height * 0.165
        
        let edgeBuffer = self.frame.width * 0.009
        
        // text buttons
        var index = 0
        for row in 0...3 {
            for column in 0...9 {
                if index < characters.count {
                    if row == 2 && column > 8 {
                        continue
                    }
                    if row == 3 && column > 7 {
                        continue
                    }
                    var xOffset: CGFloat = edgeBuffer
                    let xCoefficient: CGFloat = edgeBuffer
                    if row == 2 {
                        xOffset = buttonWidth * 0.5 + edgeBuffer
                    } else if row == 3 {
                        xOffset = buttonWidth * 0.5 + buttonWidth + (edgeBuffer * 2)
                    }
                    
                    let x = CGFloat(column) * buttonWidth + xOffset + (CGFloat(column) * xCoefficient)
                    let y = CGFloat(row) * buttonHeight + edgeBuffer + (CGFloat(row) * 7.5)
                    
                    let button = SpreeBoardButton(frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight), text: characters[index])
                    button.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
                    button.tag = index
                    
                    self.addSubview(button)
                    index = index + 1
                }
            }
        }
        
        // function buttons
        let bottomUpOne: CGFloat = 3
        let bottomRow: CGFloat = 4
        
        let modeRect = CGRect(x: edgeBuffer, y: (buttonHeight * bottomUpOne) + edgeBuffer + (bottomUpOne * 7.5), width: (buttonWidth * 1.50), height: buttonHeight)
        let buttonMode = SpreeBoardButton(frame: modeRect, text: "#")
        
        buttonMode.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        buttonMode.tag = 103
        self.addSubview(buttonMode)
        
        let deleteRect = CGRect(x: self.frame.width - (buttonWidth * 1.50) - edgeBuffer, y: (buttonHeight * bottomUpOne) + edgeBuffer + (bottomUpOne * 7.5), width: (buttonWidth * 1.50), height: buttonHeight)
        let buttonDelete = SpreeBoardButton(frame: deleteRect, text: "DEL")
        
        buttonDelete.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        buttonDelete.tag = 99
        self.addSubview(buttonDelete)
        
        let exitRect = CGRect(x: edgeBuffer, y: (buttonHeight * bottomRow) + edgeBuffer + (bottomRow * (edgeBuffer * bottomUpOne)), width: bigButtonWidth, height: buttonHeight)
        let buttonExit = SpreeBoardButton(frame: exitRect, text: "exit")
        
        buttonExit.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        buttonExit.tag = 100
        self.addSubview(buttonExit)
        
        let spaceRect = CGRect(x: (self.frame.width * 0.5) - (bigButtonWidth * 0.5) + (1.5 * edgeBuffer), y: (buttonHeight * bottomRow) + edgeBuffer + (bottomRow * (edgeBuffer * bottomUpOne)), width: bigButtonWidth, height: buttonHeight)
        let buttonSpace = SpreeBoardButton(frame: spaceRect, text: "space")
        
        buttonSpace.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        buttonSpace.tag = 101
        self.addSubview(buttonSpace)
        
        let returnRect = CGRect(x: self.frame.width - bigButtonWidth - edgeBuffer, y: (buttonHeight * bottomRow) + edgeBuffer + (bottomRow * (edgeBuffer * bottomUpOne)), width: bigButtonWidth, height: buttonHeight)
        let buttonReturn = SpreeBoardButton(frame: returnRect, text: "return")
        
        buttonReturn.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        buttonReturn.tag = 102
        self.addSubview(buttonReturn)
    }
    
    func drawNumPad() {
        self.subviews.forEach({ $0.removeFromSuperview() })
        
        // configure buttons
        let buttonWidth: CGFloat = self.frame.width * 0.32
        let buttonHeight: CGFloat = self.frame.height * 0.22
        
        let edgeBuffer = self.frame.width * 0.009
        
        // text buttons
        var index = 0
        for row in 0...3 {
            for column in 0...2 {
                if index < numPad.count {
                    var x = CGFloat(column) * buttonWidth + edgeBuffer + (CGFloat(column) * edgeBuffer)
                    let y = CGFloat(row) * buttonHeight + edgeBuffer + (CGFloat(row) * 7.5)
                    
                    if index == numPad.endIndex - 1 {
                        x = CGFloat(column + 1) * buttonWidth + edgeBuffer + (CGFloat(column + 1) * edgeBuffer)
                    }
                    
                    let button = SpreeBoardButton(frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight), text: numPad[index])
                    button.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
                    button.tag = index
                    
                    self.addSubview(button)
                    index = index + 1
                }
            }
        }
        
        // function buttons
        let bottomRow: CGFloat = 3
        
        let modeRect = CGRect(x: edgeBuffer, y: (buttonHeight * bottomRow) + edgeBuffer + (bottomRow * 7.5), width: buttonWidth, height: buttonHeight)
        let buttonMode = SpreeBoardButton(frame: modeRect, text: "ABC")
        
        buttonMode.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        buttonMode.tag = 103
        self.addSubview(buttonMode)
        
        let deleteRect = CGRect(x: self.frame.width - buttonWidth - edgeBuffer, y: (buttonHeight * bottomRow) + edgeBuffer + (bottomRow * 7.5), width: buttonWidth, height: buttonHeight)
        let buttonDelete = SpreeBoardButton(frame: deleteRect, text: "DEL")
        
        buttonDelete.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        buttonDelete.tag = 99
        self.addSubview(buttonDelete)
    }
    
    func buttonPressed(sender: UIButton) {        
        if sender.tag == 99 {
            if self.inputString.characters.count > 0 {
                self.inputString.removeAtIndex(self.inputString.endIndex.predecessor())
            }
        } else if sender.tag == 100 {
            self.delegate.dismissKeyboard()
        } else if sender.tag == 101 {
            self.inputString = self.inputString.stringByAppendingString(" ")
        } else if sender.tag == 102 {
            self.delegate.enter()
        } else if sender.tag == 103 {
            if inputState == .NumPad {
                self.drawNormalKeyboard()
                self.inputState = .Normal
            } else {
                self.drawNumPad()
                self.inputState = .NumPad
            }
        } else if let char = sender.currentTitle {
            self.inputString = self.inputString.stringByAppendingString(char)
        }
        
        self.delegate.inputUpdated(self.inputString)
    }
}