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
        if i == 12 {
            line.append("?")
        }
        else {
            line.append(d[i] > 0 ? "#" : ".")
        }
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

func bugCount(d: [Int]) -> Int {
    var bugCount = 0
    for i in d {
        if i > 0 {
            bugCount += 1
        }
    }
    return bugCount
}

func bottomLine(level: [Int]?) -> Int {
    guard level != nil else { return 0 }
    return level![20] + level![21] + level![22] + level![23] + level![24]
}

func topLine(level: [Int]?) -> Int {
    guard level != nil else { return 0 }
    return level![0] + level![1] + level![2] + level![3] + level![4]
}

func rightColumn(level: [Int]?) -> Int {
    guard level != nil else { return 0 }
    return level![4] + level![9] + level![14] + level![19] + level![24]
}

func leftColumn(level: [Int]?) -> Int {
    guard level != nil else { return 0 }
    return level![0] + level![5] + level![10] + level![15] + level![20]
}

func next2(level: [Int], prev: [Int]?, next: [Int]?) -> [Int] {
    var result = [Int]()
    
    for i in 0..<level.count {
        var nb = 0
        
        // Skip middle point
        if i == 12 {
            result.append(0)
            continue
        }
        
        // ^^^^^ Add neighbors from the top
        // First row
        if i < size && prev != nil {
            nb += prev![7]
        }
        else if i >= size {
            if i == 17 {
                nb += bottomLine(level: next)
            }
            else {
                nb += level[i - size]
            }
        }
        
        // vvvvv Add neighbors from the bottom
        // Last row
        if i >= (level.count-size) && prev != nil {
            nb += prev![17]
        }
        else if i < (level.count-size) {
            if i == 7 {
                nb += topLine(level: next)
            }
            else {
                nb += level[i+size]
            }
        }
        
        // <<<<< Add neigbors from the left
        // First column
        if (i % size) == 0 && prev != nil {
            nb += prev![11]
        }
        else if (i % size) != 0 {
            if i == 13 {
                nb += rightColumn(level: next)
            }
            else {
                nb += level[i-1]
            }
        }
        
        // >>>>> Add neighbors from the right
        // Last colum
        if ((i % size) == (size-1)) && prev != nil {
            nb += prev![13]
        }
        else if (i % size) != (size-1) {
            if i == 11 {
                nb += leftColumn(level: next)
            }
            else {
                nb += level[i+1]
            }
        }
        
        if level[i] == 0 && (nb == 1 || nb == 2) {
            result.append(1)
        }
        else if level[i] == 1 && nb != 1 {
            result.append(0)
        }
        else {
            result.append(level[i])
        }
    }
    
    return result
}

// Part 2
var startLevel = -1
var levels = [empty, input, empty]

for step in 1...200 {
    
    // Generate levels after next minute
    var newLevels = [[Int]]()
    for i in 0..<levels.count {
        newLevels.append(
            next2(level: levels[i], prev: (i > 0) ? levels[i-1] : nil, next: (i < levels.count-1) ? levels[i+1] : nil))
    }
    if bugCount(d: newLevels[0]) > 0 {
        newLevels.insert(empty, at: 0)
        startLevel -= 1
    }
    if bugCount(d: newLevels.last!) > 0 {
        newLevels.append(empty)
    }
    
    levels = newLevels
    print("After \(step) min:")

    for i in 0..<levels.count {
        print("Level: \(startLevel+i)")
        printOut(d: levels[i])
    }
}

var bugs = 0
for l in levels {
    bugs += bugCount(d: l)
}
print("Total Bugs Count: \(bugs)")


exit(0)

// Part 1
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
 
