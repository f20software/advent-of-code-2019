//
//  main.swift
//  aoc1
//
//  Created by Vladimir Svidersky on 12/7/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

var sum_part1 = 0
var sum_part2 = 0

for i in input {
    var fuel = i / 3 - 2
    sum_part1 = sum_part1 + fuel
    sum_part2 = sum_part2 + fuel
    
    while (fuel > 8) {
        fuel = fuel / 3 - 2
        sum_part2 = sum_part2 + fuel
    }
}

print("Part 1: \(sum_part1)")
print("Part 2: \(sum_part2)")

