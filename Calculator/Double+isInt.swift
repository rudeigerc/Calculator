//
//  Double+isInt.swift
//  Calculator
//
//  Created by Yuchen Cheng on 2018/5/4.
//  Copyright © 2018年 Rudeiger Cheng. All rights reserved.
//

import Foundation

extension Double {
    
    var isInt: Bool {
        if Double(Int.max) > self, Double(Int.min) < self {
            let intValue = Int(self)
            return Double(intValue) == self
        } else {
            return false
        }
    }
    
}
