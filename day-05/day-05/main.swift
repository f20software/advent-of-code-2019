//
//  main.swift
//  day-05
//
//  Created by Vladimir Svidersky on 12/11/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

func runProgram(program: [Int], input: [Int]) {

    var index = 0
    var p = program
    while (p[index] != 99) {

        switch p[index] {
            
        // Jump if-true
        case 1105:
            if p[index+1] != 0 {
                index = p[index+2]
            }
            else {
                index += 3
            }
        case 1005:
            if p[p[index+1]] != 0 {
                index = p[index+2]
            }
            else {
                index += 3
            }
        case 105:
            if p[index+1] != 0 {
                index = p[p[index+2]]
            }
            else {
                index += 3
            }
        case 5:
            if p[p[index+1]] != 0 {
                index = p[p[index+2]]
            }
            else {
                index += 3
            }
        
        // Jump if-true
        case 1106:
            if p[index+1] == 0 {
                index = p[index+2]
            }
            else {
                index += 3
            }
        case 1006:
            if p[p[index+1]] == 0 {
                index = p[index+2]
            }
            else {
                index += 3
            }
        case 106:
            if p[index+1] == 0 {
                index = p[p[index+2]]
            }
            else {
                index += 3
            }
        case 6:
            if p[p[index+1]] == 0 {
                index = p[p[index+2]]
            }
            else {
                index += 3
            }
        // Less-then
        case 1107:
            p[p[index+3]] = (p[index+1] < p[index+2]) ? 1 : 0
            index += 4
        case 1007:
            p[p[index+3]] = (p[p[index+1]] < p[index+2]) ? 1 : 0
            index += 4
        case 107:
            p[p[index+3]] = (p[index+1] < p[p[index+2]]) ? 1 : 0
            index += 4
        case 7:
            p[p[index+3]] = (p[p[index+1]] < p[p[index+2]]) ? 1 : 0
            index += 4
        // Equal-then
        case 1108:
            p[p[index+3]] = (p[index+1] == p[index+2]) ? 1 : 0
            index += 4
        case 1008:
            p[p[index+3]] = (p[p[index+1]] == p[index+2]) ? 1 : 0
            index += 4
        case 108:
            p[p[index+3]] = (p[index+1] == p[p[index+2]]) ? 1 : 0
            index += 4
        case 8:
            p[p[index+3]] = (p[p[index+1]] == p[p[index+2]]) ? 1 : 0
            index += 4

        // Addition
        case 1101:
            p[p[index+3]] = p[index+1] + p[index+2]
            index += 4
        case 1001:
            p[p[index+3]] = p[p[index+1]] + p[index+2]
            index += 4
        case 101:
            p[p[index+3]] = p[index+1] + p[p[index+2]]
            index += 4
        case 1:
            p[p[index+3]] = p[p[index+1]] + p[p[index+2]]
            index += 4

        // Multiplication
        case 1102:
            p[p[index+3]] = p[index+1] * p[index+2]
            index += 4
        case 1002:
            p[p[index+3]] = p[p[index+1]] * p[index+2]
            index += 4
        case 102:
            p[p[index+3]] = p[index+1] * p[p[index+2]]
            index += 4
        case 2:
            p[p[index+3]] = p[p[index+1]] * p[p[index+2]]
            index += 4

        // Input
        case 3:
            p[p[index+1]] = input[0]
            index += 2

        // Output
        case 4:
            print("Out: \(p[p[index+1]])")
            index += 2
        case 104:
            print("Out: \(p[index+1])")
            index += 2

        default:
            print("Failure: p[\(index)]: \(p[index])")
            exit(0)
        }
    }
}

runProgram(program: input, input: [5])

