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
        let intValue = Int(self)
        return Double(intValue) == self
    }
    
}
