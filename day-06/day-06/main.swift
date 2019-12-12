//
//  main.swift
//  day-06
//
//  Created by Vladimir Svidersky on 12/12/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

let data = input_full
var deps = [String: [String]]()
var direct_deps = [String: String]()

var orbits = [String: Int]()
var totalCount = 0
var queue = [String]()


func buildTree(d: [String]) {
    var i = 0
    while i < d.count {
        let source = d[i]
        let dest = d[i+1]
        
        direct_deps[dest] = source
        
        if deps[source] != nil {
            var newdest = deps[source]
            newdest?.append(dest)
            deps[source] = newdest!
        }
        else {
            deps[source] = [dest]
        }
        i += 2
    }
}

func fullPath(from: String) -> [String] {
    var res = [String]()
    var current = from
    
    while direct_deps[current] != nil {
        current = direct_deps[current]!
        res.append(current)
    }
    
    return res
}


// Preparation

buildTree(d: data)

// Part 1

queue.append("COM")
while queue.count > 0 {
    let next = queue[0]
    
    let directParent = direct_deps[next]
    if directParent == nil {
        orbits[next] = 0
    }
    else {
        orbits[next] = orbits[directParent!]! + 1
        totalCount += orbits[next]!
    }
    
    if deps[next] != nil {
        queue.append(contentsOf: deps[next]!)
    }
    queue.remove(at: 0)
}
print(totalCount)

// Part 2

let pathYou = fullPath(from: "YOU")
let pathSanta = fullPath(from: "SAN")

for i in 0..<pathYou.count {
    let j = pathSanta.firstIndex(of: pathYou[i])
    if j != nil {
        print(j! + i)
        exit(0)
    }
}






