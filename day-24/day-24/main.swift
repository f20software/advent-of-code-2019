//
//  main.swift
//  day-24
//
//  Created by Vladimir Svidersky on 12/25/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

var input = full
let size = 5

func printOut(d: [Int]) {
    var line = ""
    for i in 0..<d.count {
        line.append(d[i] > 0 ? "#" : ".")
        if line.lengthOfBytes(using: .utf8) == size {
            print(line)
            line = ""
        }
    }
}

func hash(d: [Int]) -> String {
    var line = ""
    for i in 0..<d.count {
        line.append(d[i] > 0 ? "#" : ".")
    }
    return line
}

func bioDiversity(d: [Int]) -> Int {
    var c = 1
    var res = 0
    
    for i in 0..<d.count {
        if d[i] == 1 {
            res += c
        }
        c *= 2
    }
    return res
}

func next(d: [Int]) -> [Int] {
    var result = [Int]()
    
    for i in 0..<d.count {
        var nb = 0
        if i >= size {
            nb += d[i - size]
        }
        if i < (d.count-size) {
            nb += d[i+size]
        }
        if (i % size) != 0 {
            nb += d[i-1]
        }
        if (i % size) != (size-1) {
            nb += d[i+1]
        }
        
        if d[i] == 0 && (nb == 1 || nb == 2) {
            result.append(1)
        }
        else if d[i] == 1 && nb != 1 {
            result.append(0)
        }
        else {
            result.append(d[i])
        }
    }
    
    return result
}

var check = [String:Bool]()

check[hash(d: input)] = true
var minute = 0

while (true) {
    input = next(d: input)
    let h = hash(d: input)
    if check[h] != nil {
        print("Found duplicate.")
        let b = bioDiversity(d: input)
        print("Biodiversity = \(b)")
        exit(0)
    }
    check[h] = true
    print(minute)
    minute += 1
}
 
