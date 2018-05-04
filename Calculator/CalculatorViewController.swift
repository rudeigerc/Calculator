//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Rudeiger Cheng on 2016/11/27.
//  Copyright © 2016 Rudeiger Cheng. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet internal weak var display: UILabel!
    
    internal var userIsInTheMiddleOfTyping = false
    internal var brain = CalculatorBrain()
    
    @IBAction internal func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            if digit == "." && textCurrentlyInDisplay.range(of: ".") != nil {
                display.text = textCurrentlyInDisplay
            } else {
                display.text = textCurrentlyInDisplay + digit
            }
        } else {
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction internal func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
        brain.isPartialResult = false    // reset isPartialResult
    }
    
    @IBAction internal func resetAll(_ sender: UIButton) {
        display.text = "0"
        brain.clear()
        userIsInTheMiddleOfTyping = false
    }
    
    internal var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            if newValue.isInt {
                display.text = String(Int(newValue))
            } else {
                display.text = String(newValue)
            }
        }
    }
    
}
