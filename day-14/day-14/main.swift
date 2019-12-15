//
//  main.swift
//  day-14
//
//  Created by Vladimir Svidersky on 12/15/19.
//  Copyright © 2019 Vladimir Svidersky. All rights reserved.
//

import Foundation

class Element: Hashable {
    static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.name == rhs.name && rhs.qty == lhs.qty
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(qty)
    }
    
    let name: String
    var qty: Int

    init(name: String, qty: Int) {
        self.name = name
        self.qty = qty
    }
    
    init(from str: String) {
        let fields = str.split(separator: " ")
        self.name = String(fields[1])
        self.qty = Int(String(fields[0]))!
    }
    
    var description: String {
        return "\(qty) \(name)"
    }
}

class Maker {

    // Map each element name to a receipe containing full element (with qty) and list of ingridients
    var recs = [String: (Element, [Element])]()

    // List of things we need to build. Process continues until the only element here is single ORE record
    var need = [Element]()
    
    // Sometime during reaction we have extra elements - store them here
    var extra = [Element]()
    
    // Total ORE count we would need
    var ore = 0

    init(receipes: [String]) {
        for line in receipes {
            parseReceipe(line)
        }

    }

    func parseReceipe(_ line: String) {
        let result = String(line.split(separator: "=")[1]).trimmingCharacters(in: CharacterSet(charactersIn: " "))
        let ingridients = String(line.split(separator: "=")[0]).trimmingCharacters(in: CharacterSet(charactersIn: " ")).split(separator: ",")
        
        let el = Element(from: result)
        var parts = [Element]()
        
        for i in ingridients {
            parts.append(Element(from: String(i).trimmingCharacters(in: CharacterSet(charactersIn: " "))))
        }
        
        recs[el.name] = (el, parts)
    }

    func make() {
        let b = need[0]
        print("need to get \(b.description)")

        if let f = extra.first(where: { (e) -> Bool in
            e.name == b.name
        }) {
            print("found some in extra storage")
            if f.qty > b.qty {
                f.qty -= b.qty
                b.qty = 0
            }
            else {
                b.qty -= f.qty
                f.qty = 0
            }
        }
        if b.qty == 0 {
            print("we can skip. got everything ready")
            need.remove(at: 0)
            return
        }

        let (result, ingredients) = recs[b.name]!
        let multi = Int((Double(b.qty) / Double(result.qty)).rounded(.up))
        
        let extra_qty = result.qty * multi - b.qty
        if extra_qty > 0 {
            print("we will have extra \(extra_qty) of \(b.name)")
            if let f = extra.first(where: { (e) -> Bool in
                e.name == b.name
            }) {
                f.qty += extra_qty
            }
            else {
                extra.append(Element(name: b.name, qty: extra_qty))
            }
        }
        
        for i in ingredients {
            if i.name == "ORE" {
                ore += i.qty * multi
            }
            else {
                if let f = need.first(where: { (e) -> Bool in
                    e.name == i.name
                }) {
                    f.qty += i.qty * multi
                }
                else {
                    need.append(Element(name: i.name, qty: i.qty * multi))
                }
            }
        }
        need.remove(at: 0)
    }
    
    func makeFuel() {
        // Using manual binary search we find the exact number wich would still produce less then 1T of ORE
        need.append(Element(name: "FUEL", qty: 4076490))
        while need.count > 0 {
            make()
        }
    }
}

let maker = Maker(receipes: input)
maker.makeFuel()

print(maker.ore, maker.ore > 1000000000000 ? "got it" : "")
