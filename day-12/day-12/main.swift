//
//  main.swift
//  day-12
//
//  Created by Vladimir Svidersky on 12/14/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

struct Point3D {
    let x: Int
    let y: Int
    let z: Int
}

class Moon {
    var p: Point3D
    var v: Point3D
    
    init(pos: Point3D) {
        self.p = pos
        self.v = Point3D(x: 0, y: 0, z: 0)
    }

    func move() {
        p = Point3D(x: p.x + v.x, y: p.y + v.y, z: p.z + v.z)
    }
    
    func adjustVelocityTo(_ m: Moon) {
        var vx = 0
        var vy = 0
        var vz = 0
        
        if p.x < m.p.x { vx = 1 }
        else if p.x > m.p.x { vx = -1 }
        if p.y < m.p.y { vy = 1 }
        else if p.y > m.p.y { vy = -1 }
        if p.z < m.p.z { vz = 1 }
        else if p.z > m.p.z { vz = -1 }

        v = Point3D(x: v.x + vx, y: v.y + vy, z: v.z + vz)
    }
    
    var energy: Int {
        return (abs(p.x) + abs(p.y) + abs(p.z)) * (abs(v.x) + abs(v.y) + abs(v.z))
    }

    var hashX: String {
        return "pos: [\(p.x)], vel: [\(v.x)]"
    }

    var hashY: String {
        return "pos: [\(p.y)], vel: [\(v.y)]"
    }

    var hashZ: String {
        return "pos: [\(p.z)], vel: [\(v.z)]"
    }

    var descrption: String {
        return "pos: [\(p.x), \(p.y), \(p.z)], vel: [\(v.x), \(v.y), \(v.z)]"
    }
}

let moons = moons_full

// Part 1

let maxSteps = 1000
for step in 1...maxSteps {
    for i in 0..<3 {
        for j in i+1...3 {
            moons[i].adjustVelocityTo(moons[j])
            moons[j].adjustVelocityTo(moons[i])
        }
    }

    for m in moons {
        m.move()
    }

    // print("\n\(step): \n\t\(moons[0].descrption),\n\t\(moons[1].descrption),\n\t\(moons[2].descrption),\n\t\(moons[3].descrption)")
}

print("total energy after \(maxSteps) steps: \(moons.map { $0.energy }.reduce(.zero, +))")

// Part 2

// Use dictionary to catch cycles in each axis
var matchesX = [String:Bool]()
var matchesY = [String:Bool]()
var matchesZ = [String:Bool]()

var foundX: Bool = false
var foundY: Bool = false
var foundZ: Bool = false

var step = 1
while(true) {

    for i in 0..<3 {
        for j in i+1...3 {
            moons[i].adjustVelocityTo(moons[j])
            moons[j].adjustVelocityTo(moons[i])
        }
    }

    for m in moons {
        m.move()
    }

    var hash = ""
    
    if foundX == false {
        hash = "\(moons[0].hashX),\(moons[1].hashX),\(moons[2].hashX),\(moons[3].hashX)"
        if matchesX[hash] == nil {
            matchesX[hash] = true
        }
        else {
            print("found cycle for X: step = \(step-1)")
            foundX = true
        }
    }

    if foundY == false {
        hash = "\(moons[0].hashY),\(moons[1].hashY),\(moons[2].hashY),\(moons[3].hashY)"
        if matchesY[hash] == nil {
            matchesY[hash] = true
        }
        else {
            print("found cycle for Y: step = \(step-1)")
            foundY = true
        }
    }

    if foundZ == false {
        hash = "\(moons[0].hashZ),\(moons[1].hashZ),\(moons[2].hashZ),\(moons[3].hashZ)"
        if matchesZ[hash] == nil {
            matchesZ[hash] = true
        }
        else {
            print("found cycle for Z: step = \(step-1)")
            foundZ = true
        }
    }

    if (foundX && foundY && foundZ) {
        print("All cycles are found. The answer to the Part 2 is LCM of these 3 numbers")
        exit(0)
    }
    
    step += 1
}
