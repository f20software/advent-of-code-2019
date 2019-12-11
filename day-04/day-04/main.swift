//
//  main.swift
//  day-04
//
//  Created by Vladimir Svidersky on 12/8/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

let len = 6

class Password : Comparable {

    static func < (lhs: Password, rhs: Password) -> Bool {
        for i in 0..<len {
            if lhs.data[i] < rhs.data[i] {
                return true
            }
            else if lhs.data[i] > rhs.data[i] {
                return false
            }
        }
        
        return false
    }
    
    static func == (lhs: Password, rhs: Password) -> Bool {
        for i in 0..<len {
            if lhs.data[i] != rhs.data[i] {
                return false
            }
        }
        
        return true
    }
    
    var data: [Int]
    
    init(data: [Int]) {
        self.data = data
    }
    
    @discardableResult func findAndFixFirstDecrease() -> Bool {
        var firstDecrease = -1
        for i in 0..<(len-1) {
            if data[i] > data[i+1] {
                firstDecrease = i
                break
            }
        }
        
        if firstDecrease >= 0 {
            for i in firstDecrease+1..<len {
                data[i] = data[firstDecrease]
            }
            return true
        }
        
        return false
    }
    
    @discardableResult func incrementOne() -> Bool {
        var lastNonNine = -1

        for i in 1...len {
            if data[len-i] < 9 {
                lastNonNine = len-i
                break
            }
        }
        
        if lastNonNine >= 0 {
            data[lastNonNine] += 1
            if lastNonNine < len-1 {
                for i in lastNonNine+1..<len {
                    data[i] = data[lastNonNine]
                }
            }
            
            return true
        }
        
        return false
    }
    
    func next() {
        if findAndFixFirstDecrease() {
            return
        }
        
        incrementOne()
    }
    
    var isValid1: Bool {
        for i in 0..<len-1 {
            if data[i] == data[i+1] {
                return true
            }
        }
        
        return false
    }

    var isValid2: Bool {
        var groupDigit = -1
        var groupLen = 0
        
        for i in 0..<len {
            if groupDigit < 0 {
                groupDigit = data[i]
                groupLen = 1
            }
            else if groupDigit == data[i] {
                groupLen += 1
            }
            else /* groupDigit != data[i] */ {
                if groupLen == 2 {
                    return true
                }
                groupDigit = data[i]
                groupLen = 1
            }
        }
        
        if groupLen == 2 {
            return true
        }
        
        return false
    }

    var output: String {
        var str = ""
        for i in 0..<len {
            str += "\(data[i])"
        }
        
        if isValid1 {
            str += " ok!"
        }
        
        if isValid2 {
            str += " double-ok!"
        }

        return str
    }
}


var p1 = Password(data: [1,5,8,1,2,6])
p1.findAndFixFirstDecrease()
var p2 = Password(data: [6,2,4,5,7,4])
var validCount1 = 0
var validCount2 = 0

while p1 < p2 {
    print(p1.output)
    if p1.isValid1 {
        validCount1 += 1
    }
    if p1.isValid2 {
        validCount2 += 1
    }
    p1.next()
}

print("End. Total valid passwords: \(validCount1) - part 1, \(validCount2) - part 2")

