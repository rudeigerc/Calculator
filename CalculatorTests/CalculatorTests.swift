//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Yuchen Cheng on 2018/4/19.
//  Copyright © 2018年 Rudeiger Cheng. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Calculator

class CalculatorTests: XCTestCase {
    
    var calculatorViewController: CalculatorViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculatorViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! CalculatorViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        calculatorViewController = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
