//
//  main.swift
//  day-11
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
    
    var descrption: String {
        return "pos: [\(p.x), \(p.y), \(p.z)], vel: [\(v.x), \(v.y), \(v.z)]"
    }
}

var moons = [
    Moon(pos: Point3D(x: 16, y: -8, z: 13)),
    Moon(pos: Point3D(x: 4, y: 10, z: 10)),
    Moon(pos: Point3D(x: 17, y: -5, z: 6)),
    Moon(pos: Point3D(x: 13, y: -3, z: 0))
]

for step in 1...1000 {
    for i in 0..<3 {
        for j in i+1...3 {
            moons[i].adjustVelocityTo(moons[j])
            moons[j].adjustVelocityTo(moons[i])
        }
    }

    for m in moons {
        m.move()
    }

    print("\n\(step): \n\t\(moons[0].descrption),\n\t\(moons[1].descrption),\n\t\(moons[2].descrption),\n\t\(moons[3].descrption)")
}

print("total energy: \(moons.map { $0.energy }.reduce(.zero, +))")

