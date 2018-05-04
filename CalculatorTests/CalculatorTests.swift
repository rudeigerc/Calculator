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
            
            describe("click button") {
                beforeEach {
                    button = UIButton()
                }
                
                describe("when the button is a dot") {
                    beforeEach {
                        button.setTitle(".", for: .normal)
                        calculatorViewController.touchDigit(button)
                    }
                    
                    it("prints zero plus a dot") {
                        
                        expect(calculatorViewController.display.text).to(equal("0."))
                    }
                }
                
                describe("when the button is a digit") {
                    beforeEach {
                        button.setTitle("1", for: .normal)
                        calculatorViewController.touchDigit(button)
                    }
                    
                    it("prints the digit") {
                        expect(calculatorViewController.display.text).to(equal("1"))
                    }
                    
                    describe("when the button is a dot") {
                        beforeEach {
                            button.setTitle(".", for: .normal)
                            calculatorViewController.touchDigit(button)
                        }
                        
                        it("prints one plus a dot") {
                            expect(calculatorViewController.display.text).to(equal("1."))
                        }
                    }
                    
                    describe("when the button is a digit") {
                        beforeEach {
                            button.setTitle("2", for: .normal)
                            calculatorViewController.touchDigit(button)
                        }
                        
                        it("prints one plus a dot") {
                            expect(calculatorViewController.display.text).to(equal("12"))
                        }
                    }
                }
                
                describe("when the button is C") {
                    beforeEach {
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
