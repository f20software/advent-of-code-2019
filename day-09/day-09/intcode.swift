//
//  intcode.swift
//  day-07
//
//  Created by Vladimir Svidersky on 12/12/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

class IntComputer {

    enum AddressMode: Int {
        case position = 0
        case immediate = 1
        case relative = 2
    }
    
    enum OpCode: Int {
        case add = 1
        case mult = 2
        case inp = 3
        case out = 4
        case jnz = 5
        case jz = 6
        case less = 7
        case equal = 8
        case rel = 9
        case exit = 99
    }
    
    var mem: [Int]
    var index = 0
    var relativeIndex = 0
    
    init (program: [Int]) {
        mem = program
        let empty = Array(repeating: 0, count: 10000)
        mem.append(contentsOf: empty)
    }
    
    func reset(program: [Int]) {
        mem = program
        let empty = Array(repeating: 0, count: 10000)
        mem.append(contentsOf: empty)
    }
    
    func opcode(d: Int) -> OpCode {
        return OpCode(rawValue: d % 100)!
    }
    
    func mode1(d: Int) -> AddressMode {
        return AddressMode(rawValue: d % 1000 / 100)!
    }
    
    func mode2(d: Int) -> AddressMode {
        return AddressMode(rawValue: d % 10000 / 1000)!
    }

    func mode3(d: Int) -> AddressMode {
        return AddressMode(rawValue: d % 100000 / 10000)!
    }

    func value(_ i: Int, mode: AddressMode) -> Int {
        switch mode {
        case .position: return mem[mem[i]]
        case .immediate: return mem[i]
        case .relative: return mem[mem[i]+relativeIndex]
        }
    }

    func address(_ i: Int, mode: AddressMode) -> Int {
        switch mode {
        case .position: return mem[i]
        case .immediate: return mem[i]
        case .relative: return mem[i]+relativeIndex
        }
    }

    func run(input: [Int]) -> [Int] {

        index = 0
        var inputIndex = 0
        var output = [Int]()
        
        while (opcode(d: mem[index]) != .exit) {

            let m1 = mode1(d: mem[index])
            let m2 = mode2(d: mem[index])
            let m3 = mode3(d: mem[index])
            let oc = opcode(d: mem[index])
            
            switch oc {
            case .add:
                mem[address(index+3, mode: m3)] = value(index+1, mode: m1) + value(index+2, mode: m2)
                index += 4

            case .mult:
                mem[address(index+3, mode: m3)] = value(index+1, mode: m1) * value(index+2, mode: m2)
                index += 4

            case .inp:
                mem[address(index+1, mode: m1)] = input[inputIndex]
                inputIndex += 1
                index += 2
                
            case .out:
                print(value(index+1, mode: m1))
                output.append(value(index+1, mode: m1))
                index += 2
                
            case .jnz:
                if value(index+1, mode: m1) != 0 {
                    index = value(index+2, mode: m2)
                }
                else {
                    index += 3
                }

            case .jz:
                if value(index+1, mode: m1) == 0 {
                    index = value(index+2, mode: m2)
                }
                else {
                    index += 3
                }
                
            case .less:
                mem[address(index+3, mode: m3)] = value(index+1, mode: m1) < value(index+2, mode: m2) ? 1 : 0
                index += 4

            case .equal:
                mem[address(index+3, mode: m3)] = value(index+1, mode: m1) == value(index+2, mode: m2) ? 1 : 0
                index += 4
                
            case .rel:
                relativeIndex += value(index+1, mode: m1)
                index += 2

            default:
                print("Failure: mem[\(index)]: \(mem[index])")
                exit(1)
            }
        }
        
        return output
    }

}
