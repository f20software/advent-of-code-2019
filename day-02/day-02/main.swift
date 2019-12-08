//
//  main.swift
//  day-02
//
//  Created by Vladimir Svidersky on 12/7/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

// Part 2

for p1 in 0...99 {
    for p2 in 0...99 {
        
        var index = 0
        var p = input

        p[1] = p1
        p[2] = p2

        while (p[index] != 99) {

            switch p[index] {
            case 1:
                p[p[index+3]] = p[p[index+1]] + p[p[index+2]]
            case 2:
                p[p[index+3]] = p[p[index+1]] * p[p[index+2]]
            default:
                print("Failure: p[\(index)]: \(p[index])")
                exit(0)
            }
            index = index + 4
        }

        print("End: \(p[0])")
        if (p[0] == 19690720) {
            print("We got it. \(p1), \(p2)")
            exit(0)
        }

    }
}

exit(0)

// Part 1
var index = 0
var p = input

p[1] = 12
p[2] = 2

while (p[index] != 99) {

    switch p[index] {
    case 1:
        p[p[index+3]] = p[p[index+1]] + p[p[index+2]]
    case 2:
        p[p[index+3]] = p[p[index+1]] * p[p[index+2]]
    default:
        print("Failure: p[\(index)]: \(p[index])")
        exit(0)
    }
    index = index + 4
}

print("End: \(p[0])")

