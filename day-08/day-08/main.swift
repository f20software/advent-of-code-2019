//
//  main.swift
//  day-08
//
//  Created by Vladimir Svidersky on 12/8/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

let width = 25 // 3
let height = 6 // 2
let layerSize: Int = width * height


class Layer {
    var data: [Int] = [Int]()
    
    var count0 = 0
    var count1 = 0
    var count2 = 0

    init() {
    }

    convenience init(input: String, offset: Int, count: Int) {
        self.init()
        
        for i in 0..<count {
            let idx = input.index(input.startIndex, offsetBy: (offset+i))
            let c = input[idx]
            
            let number = c.wholeNumberValue!
            data.append(number)
            if number == 0 {
                count0 += 1
            }
            if number == 1 {
                count1 += 1
            }
            if number == 2 {
                count2 += 1
            }
        }
    }
    
    func printOut(width: Int, height: Int) {
        var i = 0
        for _ in 0..<height {
            var str = ""
            for _ in 0..<width {
                str = str + "\(data[i] == 0 ? " " : "x")"
                i += 1
            }
            print("\(str)")
        }
    }
}

var layers = [Layer]()
var layersCount = input.lengthOfBytes(using: .ascii) / (width * height)
var offset = 0

while layersCount > 0 {
    layers.append(Layer(input: input, offset: offset, count: layerSize))
    layersCount -= 1
    offset += layerSize
}

// Part 2

var result = Layer()
for i in 0..<layerSize {
    result.data.append(layers.map({ $0.data[i] }).first(where: { $0 != 2 }) ?? 0)
}

print("Part 2:")
result.printOut(width: width, height: height)


// Part 1
print("Part 1:")
var min0 = layers.min(by: { (a, b) in
    return a.count0 < b.count0
})!

print(min0.count1, min0.count2)

print("End")
