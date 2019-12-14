//
//  main.swift
//  day-10
//
//  Created by Vladimir Svidersky on 12/14/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

extension StringProtocol {
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
}

func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
    var modifiedString = String()
    for (i, char) in myString.enumerated() {
        modifiedString += String((i == index) ? newChar : char)
    }
    return modifiedString
}

class Radar {
    
    var map: [String]
    var x: Int
    var y: Int
    var size: Int
    
    init(map: [String], x: Int, y: Int, size: Int) {
        self.map = map
        self.x = x
        self.y = y
        self.size = size
    }
    
    
    func printMap() {
        for l in map {
            print(l)
        }
    }
    
    func isValidPoint(x: Int, y: Int) -> Bool {
        if (x < 0 || x >= size || y < 0 || y >= size) {
            return false
        }

        return true
    }
    
    func gcdIterativeEuklid(_ m: Int, _ n: Int) -> Int {
        var a: Int = 0
        var b: Int = max(m, n)
        var r: Int = min(m, n)

        while r != 0 {
            a = b
            b = r
            r = a % b
        }
        return b
    }
    
    func scanPoint(px: Int, py: Int) -> Int {
        if isValidPoint(x: px, y: py) == false {
            return 0
        }

        // print("Scaning point \(px), \(py)")
        
        if map[py][px] == "#" {
            var dx = px - x
            var dy = py - y

            if dx == 0 {
                dy = dy / abs(dy)
            }
            else if dy == 0 {
                dx = dx / abs(dx)
            }
            else {
                let gcd = gcdIterativeEuklid(abs(dx), abs(dy))
                if gcd > 1 {
                    dx = dx / gcd
                    dy = dy / gcd
                }
            }
            
            var npx = px + dx
            var npy = py + dy
            while (isValidPoint(x: npx, y: npy)) {
                if map[npy][npx] == "#" {
                    // print("point \(npx),\(npy) becomes invisible")
                    map[npy] = replace(myString: map[npy], npx, "*")
                    // print(map[npy])
                }
                npx += dx
                npy += dy
            }
            
            return 1
        }
        return 0
    }
    
    func subScan(level: Int) -> Int {
        var total = 0

        // Top horizontal line
        for x1 in x-level..<x+level {
            total += scanPoint(px: x1, py: y-level)
        }
        // Right vertical line
        for y1 in y-level..<y+level {
            total += scanPoint(px: x+level, py: y1)
        }
        // Bottom horizontal line
        for x1 in x-level+1...x+level {
            total += scanPoint(px: x1, py: y+level)
        }
        // Left vertical line
        for y1 in y-level+1...y+level {
            total += scanPoint(px: x-level, py: y1)
        }

        return total
    }

    func scan() -> Int {
        if map[y][x] == "." {
            return -1
        }
        
        map[y] = replace(myString: map[y], x, "R")
        
        let maxLevel = [x, y, size-x, size-y].max()!
        var totalVisible = 0
        
        for level in 1...maxLevel {
            totalVisible += subScan(level: level)
            // print("Scanned level \(level). Total visible \(totalVisible)")
            // printMap()
        }
        
        printMap()
        return totalVisible
    }
}

let size = 26
let map = input

var maxVisible = -1

//let r = Radar(map: map, x: 5, y: 8, size: size)
//let visible = r.scan()
//print("Point 3, 4 - visible \(visible)")

for y in 0..<size {
    for x in 0..<size {
        let r = Radar(map: map, x: x, y: y, size: size)
        let visible = r.scan()
        print("Point \(x), \(y) - visible \(visible)")
        if visible > maxVisible {
            print("At \(x),\(y) max visible is \(visible)")
            maxVisible = visible
        }
    }
}




