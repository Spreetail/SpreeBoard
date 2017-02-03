//
//  ViewController.swift
//  SpreeBoard
//
//  Created by Trevor Poppen on 01/31/2017.
//  Copyright (c) 2017 Trevor Poppen. All rights reserved.
//

import UIKit
import SpreeBoard

class ViewController: UIViewController, SpreeBoardDelegate {

    @IBOutlet weak var textFieldInput: UITextField!
    @IBOutlet weak var labelOutput: UILabel!
    
    var sb: SpreeBoard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spreeboardFrame = CGRect(x: 0, y: self.view.frame.height * 0.45, width: self.view.frame.width, height: self.view.frame.height * 0.45)
        self.sb = SpreeBoard(frame: spreeboardFrame, state: .Normal, delegate: self)
        self.sb.alpha = 1
        self.sb.tag = 123
        
        self.textFieldInput.inputView = self.sb
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Delegate methods for SpreeBoard
    func inputUpdated(input: String) {
        self.textFieldInput.attributedText = NSAttributedString(string: input)
    }
    
    func enter() {
        self.labelOutput.text = self.textFieldInput.text
        self.textFieldInput.resignFirstResponder()
    }
    
    func dismissKeyboard() {
        self.textFieldInput.resignFirstResponder()
    }

}

