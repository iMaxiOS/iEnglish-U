//
//  Extentions.swift
//  iEnglish U
//
//  Created by iMaxiOS on 8/6/18.
//  Copyright © 2018 Maxim Granchenko. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        for i in 0 ..< (count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swapAt(i, j)
        }
    }
}
