//
//  main.swift
//  day-03
//
//  Created by Vladimir Svidersky on 12/8/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

struct Point: Equatable {
    let x: Int
    let y: Int
}

struct Section {
    let direction: String
    let x1: Int
    let y1: Int
    let x2: Int
    let y2: Int

    var length: Int {
        if direction == "R" || direction == "L" {
            return x2 - x1 + 1
        }
        else /* if direction == "U" || direction == "D" */ {
            return y2 - y1 + 1
        }
    }
    
    func distanceTo(p: Point) -> Int {
        if direction == "R" {
            return p.x - x1 + 1
        }
        else if direction == "L" {
            return x2 - p.x + 1
        }
        else if direction == "U" {
            return p.y - y1 + 1
        }
        else /* if direction == "D" */ {
            return y2 - p.y + 1
        }
    }
    
    var allPoints: [Point] {
        var res = [Point]()
        if direction == "R" || direction == "L" {
            for i in x1...x2 {
                res.append(Point(x: i, y: y1))
            }
            return res
        }
        else /* if direction == "U" || direction == "D" */ {
            for i in y1...y2 {
                res.append(Point(x: x1, y: i))
            }
            return res
        }
    }
    
    func contains(p: Point) -> Bool {
        if direction == "R" || direction == "L" {
            return p.y == y1 && p.x >= x1 && p.x <= x2
        }
        if direction == "U" || direction == "D" {
            return p.x == x1 && p.y >= y1 && p.y <= y2
        }
        return false
    }
}

class Wire {
    var sections: [Section] = [Section]()
    
    init(data: [String]) {
        var currentX = 0
        var currentY = 0
        
        for step in data {
            let direction = step.prefix(1)
            let len = Int(step[step.index(after: step.startIndex)...])!
            switch direction {
            case "R":
                sections.append(Section(direction: "R", x1: currentX+1, y1: currentY, x2: currentX+len, y2: currentY))
                currentX += len
            case "L":
                sections.append(Section(direction: "L", x1: currentX-len, y1: currentY, x2: currentX-1, y2: currentY))
                currentX -= len
            case "U":
                sections.append(Section(direction: "U", x1: currentX, y1: currentY+1, x2: currentX, y2: currentY+len))
                currentY += len
            case "D":
                sections.append(Section(direction: "D", x1: currentX, y1: currentY-len, x2: currentX, y2: currentY-1))
                currentY -= len
            default:
                break
            }
        }
    }
    
    var allPoints: [Point] {
        var res = [Point]()
        for i in sections {
            res.append(contentsOf: i.allPoints)
        }
        return res
    }
    
    func distanceTo(p: Point) -> Int {
        var distance = 0
        for i in sections {
            if i.contains(p: p) {
                distance += i.distanceTo(p: p)
                return distance
            }
            else {
                distance += i.length
            }
        }
        return distance
    }
    
    func contains(p: Point) -> Bool {
        for i in sections {
            if i.contains(p: p) {
                return true
            }
        }
        return false
    }
}

let w1 = Wire(data: input[0])
let w2 = Wire(data: input[1])

let crossing = w2.allPoints.filter { w1.contains(p: $0) }

// Part 1
let min = crossing.min { (a, b) -> Bool in
    abs(a.x) + abs(a.y) < abs(b.x) + abs(b.y)
}!

print("End, \(min), \(abs(min.x) + abs(min.y))")

// Part 2
let min2 = crossing.min { (a, b) -> Bool in
    w1.distanceTo(p: a) + w2.distanceTo(p: a) < w1.distanceTo(p: b) + w2.distanceTo(p: b)
}!

print("End, \(min2), \(w1.distanceTo(p: min2) + w2.distanceTo(p: min2))")

