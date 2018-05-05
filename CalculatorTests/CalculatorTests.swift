//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Yuchen Cheng on 2018/4/19.
//  Copyright © 2018年 Rudeiger Cheng. All rights reserved.
//

import Quick
import Nimble
@testable import Calculator

class CalculatorTests: QuickSpec {
    
    override func spec() {
        
        var calculatorViewController: CalculatorViewController!
        
        describe("calculator") {
            
            var button: UIButton!
            
            beforeEach {
                calculatorViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController
                _ = calculatorViewController.view
            }
            
            describe("press a button") {
                beforeEach {
                    button = UIButton()
                }
                
                context(".") {
                    beforeEach {
                        button.setTitle(".", for: .normal)
                        calculatorViewController.touchDigit(button)
                    }
                    
                    it("prints 0.") {
                        expect(calculatorViewController.display.text).to(equal("0."))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(true))
                    }
                    
                }
                
                context(". .") {
                    beforeEach {
                        button.setTitle(".", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle(".", for: .normal)
                        calculatorViewController.touchDigit(button)
                    }
                    
                    it("prints 0.") {
                        expect(calculatorViewController.display.text).to(equal("0."))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(true))
                    }
                }
                
                context("1") {
                    beforeEach {
                        button.setTitle("1", for: .normal)
                        calculatorViewController.touchDigit(button)
                    }
                    
                    it("prints the digit") {
                        expect(calculatorViewController.display.text).to(equal("1"))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(true))
                    }
                }
                
                context("1 .") {
                    beforeEach {
                        button.setTitle("1", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle(".", for: .normal)
                        calculatorViewController.touchDigit(button)
                    }
                    
                    it("prints 1.") {
                        expect(calculatorViewController.display.text).to(equal("1."))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(true))
                    }
                }
                
                context("1 log") {
                    beforeEach {
                        button.setTitle("1", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("log", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints 0") {
                        expect(calculatorViewController.display.text).to(equal("0"))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                
                context("1 −") {
                    beforeEach {
                        button.setTitle("1", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("−", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints 1") {
                        expect(calculatorViewController.display.text).to(equal("1"))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                
                context("1 − 3") {
                    beforeEach {
                        button.setTitle("1", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("−", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("3", for: .normal)
                        calculatorViewController.touchDigit(button)
                    }
                    
                    it("prints 3") {
                        expect(calculatorViewController.display.text).to(equal("3"))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(true))
                    }
                }
                
                context("1 − 3 =") {
                    beforeEach {
                        button.setTitle("1", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("−", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("3", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("=", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints -2") {
                        expect(calculatorViewController.display.text).to(equal("-2"))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                
                context("1 − 3 √") {
                    beforeEach {
                        button.setTitle("1", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("−", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("3", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("√", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints sqrt(3)") {
                        expect(Double(calculatorViewController.display.text!)).to(beCloseTo(sqrt(3)))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                
                context("e") {
                    beforeEach {
                        button.setTitle("e", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints the value of e") {
                        expect(Double(calculatorViewController.display.text!)).to(beCloseTo(M_E))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                    
                context("e +") {
                    beforeEach {
                        button.setTitle("e", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("+", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints the value of e") {
                        expect(Double(calculatorViewController.display.text!)).to(beCloseTo(M_E))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                    
                context("e + π") {
                    beforeEach {
                        button.setTitle("e", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("+", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("π", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints the value of π") {
                        expect(Double(calculatorViewController.display.text!)).to(beCloseTo(.pi))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                    
                context("e + π =") {
                    beforeEach {
                        button.setTitle("e", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("+", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("π", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("=", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints the value of e plus π") {
                        expect(Double(calculatorViewController.display.text!)).to(beCloseTo(.pi + M_E))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                
                context("1 × 3 =") {
                    beforeEach {
                        button.setTitle("1", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("×", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("3", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("=", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints 3") {
                        expect(calculatorViewController.display.text).to(equal("3"))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                
                context("3 ÷ 2 =") {
                    beforeEach {
                        button.setTitle("3", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("÷", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("2", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("=", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints 1.5") {
                        expect(calculatorViewController.display.text).to(equal("1.5"))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                
                context("3 ^ 2 =") {
                    beforeEach {
                        button.setTitle("3", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("^", for: .normal)
                        calculatorViewController.performOperation(button)
                        button.setTitle("2", for: .normal)
                        calculatorViewController.touchDigit(button)
                        button.setTitle("=", for: .normal)
                        calculatorViewController.performOperation(button)
                    }
                    
                    it("prints 9") {
                        expect(calculatorViewController.display.text).to(equal("9"))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                    }
                }
                    
                context("C") {
                    beforeEach {
                        button.setTitle("C", for: .normal)
                        calculatorViewController.resetAll(button)
                    }
                    
                    it("clears all") {
                        expect(calculatorViewController.display.text).to(equal("0"))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                        expect(calculatorViewController.brain.accumulator).to(equal(0.0))
                        expect(calculatorViewController.brain.description.isEmpty).to(equal(true))
                    }
                }
                
                afterEach {
                    button = nil
                }
            }
            
            afterEach {
                calculatorViewController = nil
            }
        }
    }
}
