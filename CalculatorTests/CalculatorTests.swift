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
                
                context("when the button is a dot") {
                    beforeEach {
                        button.setTitle(".", for: .normal)
                        calculatorViewController.touchDigit(button)
                    }
                    
                    it("prints zero plus a dot") {
                        expect(calculatorViewController.display.text).to(equal("0."))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(true))
                    }
                    
                    context("when the button is a dot") {
                        beforeEach {
                            button.setTitle(".", for: .normal)
                            calculatorViewController.touchDigit(button)
                        }
                        
                        it("remains the same") {
                            expect(calculatorViewController.display.text).to(equal("0."))
                            expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(true))
                        }
                    }
                }
                
                context("when the button is a digit") {
                    beforeEach {
                        button.setTitle("1", for: .normal)
                        calculatorViewController.touchDigit(button)
                    }
                    
                    it("prints the digit") {
                        expect(calculatorViewController.display.text).to(equal("1"))
                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(true))
                    }
                    
                    context("when the button is a dot") {
                        beforeEach {
                            button.setTitle(".", for: .normal)
                            calculatorViewController.touchDigit(button)
                        }
                        
                        it("prints one plus a dot") {
                            expect(calculatorViewController.display.text).to(equal("1."))
                            expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(true))
                        }
                    }
                    
                    context("when the button is a unary operation") {
                        beforeEach {
                            button.setTitle("log", for: .normal)
                            calculatorViewController.performOperation(button)
                        }
                        
                        it("prints zero") {
                            expect(calculatorViewController.display.text).to(equal("0"))
                            expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                        }
                    }
                    
                    context("when the button is a binary operation") {
                        beforeEach {
                            button.setTitle("-", for: .normal)
                            calculatorViewController.performOperation(button)
                        }
                        
                        it("remains the same") {
                            expect(calculatorViewController.display.text).to(equal("1"))
                            expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                        }
                        
                        context("when the button is a digit") {
                            beforeEach {
                                button.setTitle("1", for: .normal)
                                calculatorViewController.touchDigit(button)
                            }
                            
                            it("prints the digit") {
                                expect(calculatorViewController.display.text).to(equal("1"))
                                expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(true))
                            }
                        }
                    }
                    
                    context("when the button is a constant") {
                        beforeEach {
                            button.setTitle("e", for: .normal)
                            calculatorViewController.performOperation(button)
                        }
                        
                        it("prints the value of e") {
                            expect(Double(calculatorViewController.display.text!)).to(beCloseTo(M_E))
                            expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                        }
                        
                        context("when the button is a binary operation") {
                            beforeEach {
                                button.setTitle("+", for: .normal)
                                calculatorViewController.performOperation(button)
                            }
                            
                            it("remains the same") {
                                expect(Double(calculatorViewController.display.text!)).to(beCloseTo(M_E))
                                expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                            }
                            
                            context("when the button is a constant") {
                                beforeEach {
                                    button.setTitle("π", for: .normal)
                                    calculatorViewController.performOperation(button)
                                }
                                
                                it("prints the value of π") {
                                    expect(Double(calculatorViewController.display.text!)).to(beCloseTo(.pi))
                                    expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                                }
                                
                                context("when the button is equal") {
                                    beforeEach {
                                        button.setTitle("=", for: .normal)
                                        calculatorViewController.performOperation(button)
                                    }
                                    
                                    it("prints the result of e + π") {
                                        expect(Double(calculatorViewController.display.text!)).to(beCloseTo(.pi + M_E))
                                        expect(calculatorViewController.userIsInTheMiddleOfTyping).to(equal(false))
                                    }
                                }
                            }
                        }
                        
                    }
                    
                    context("when the button is C") {
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
}
