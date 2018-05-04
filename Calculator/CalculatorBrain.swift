//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Rudeiger Cheng on 2016/11/28.
//  Copyright © 2016 Rudeiger Cheng. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    internal var accumulator = 0.0
    internal var isInProcessOfCalculating = false
    internal var isUnary = false
    var isPartialResult = false
    var description = ""
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    internal var operations: [String: Operation] = [
        "π": Operation.Constant(Double.pi),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "sin": Operation.UnaryOperation(sin),
        "cos": Operation.UnaryOperation(cos),
        "tan": Operation.UnaryOperation(tan),
        "log": Operation.UnaryOperation(log10),
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }),
        "^": Operation.BinaryOperation({ pow($0, $1) }),
        "=": Operation.Equals
    ]
    
    internal enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                if isInProcessOfCalculating {
                    description += "\(symbol)"
                    isPartialResult = false
                    isInProcessOfCalculating = false
                    isUnary = true
                } else {
                    description = "\(symbol)"
                    isPartialResult = true
                }
                accumulator = value
                
            case .UnaryOperation(let foo):
                if isInProcessOfCalculating {
                    description += "\(symbol)(\(accumulator))"
                    isInProcessOfCalculating = false
                    isPartialResult = false
                    isUnary = true
                } else {
                    description = "\(symbol)(\(accumulator))"
                    isPartialResult = true
                }
                accumulator = foo(accumulator)
                
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                description += " \(symbol) "
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
                isInProcessOfCalculating = true
                
            case .Equals:
                executePendingBinaryOperation()
                isInProcessOfCalculating = false
                isPartialResult = true
                isUnary = false
            }
        }
    }
    
    internal func executePendingBinaryOperation() {
        if pending != nil {
            if !isUnary {
                description += "\(accumulator)"
                isUnary = false
            }
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        } else {
            description = "\(accumulator)"
        }
    }
    
    internal var pending: PendingBinaryOperationInfo?
    
    internal struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    func clear() {
        description.removeAll()
        pending = nil
        accumulator = 0.0
    }
    
    var result: Double { return accumulator }
    
}
