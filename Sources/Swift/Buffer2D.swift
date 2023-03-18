//
//  Buffer2D.swift
//  NoiseExplorer
//
//  Created by Carlyn Maw on 3/11/23.
//

import Foundation

public struct Buffer2D<Element> {
    
    public let values:[Element]
    public let width:Int
    
    static func indexForPoint(x:Int, y:Int, width:Int) -> Int {
        (y * width) + x
    }
    
    static func pointForIndex(index:Int, width:Int) -> (x:Int, y:Int){
        let (q, r) = index.quotientAndRemainder(dividingBy: width)
        return (x:r, y:q)
    }
    
    static func rowCount(length:Int, width:Int) -> Int {
        //no results are negative. also let result = (x - 1 + n) / n ??
        let division = length.quotientAndRemainder(dividingBy: width)
        return division.quotient + (division.remainder == 0 ? 0 : 1)
    }
    
    var colCount:Int {
        width
    }
    
    var rowCount:Int {
        Self.rowCount(length: values.count, width: width)
    }
    
    func valueFor(x:Int, y:Int) -> Element {
        guard let index = indexFor(x: x, y: x) else {
            fatalError("handle index out of bounds")
        }
        return values[index]
        
    }
    
    func indexFor(x:Int, y:Int) -> Int? {
        let possibleIndex = Self.indexForPoint(x:x, y:y, width:width)
        if values.count > possibleIndex { return possibleIndex }
        else { return nil }
    }
    

}

public extension Buffer2D where Element:BinaryFloatingPoint {
    func asciiPrint() {
        for (index, item) in values.enumerated() {
            if index % width == 0 { print("") }
            switch (item) {
            case 0..<0.1: print(".", terminator:"")
            case 0.1..<0.2: print("`", terminator:"")
            case 0.2..<0.3: print("~", terminator:"")
            case 0.3..<0.4: print(":", terminator:"")
            case 0.4..<0.5: print("o", terminator:"")
            case 0.5..<0.6: print("+", terminator:"")
            case 0.6..<0.7: print("*", terminator:"")
            case 0.7..<0.8: print("#", terminator:"")
            case 0.8..<0.9: print("%", terminator:"")
            case 0.9..<1.0: print("@", terminator:"")
            default:print("0", terminator:"")
            }
            //print(item, terminator:"")
            
        }
    }
    
    func asciiBWPrint() {
        for (index, item) in values.enumerated() {
            if index % width == 0 { print("") }
            switch (item) {
            case 0..<0.5: print("_", terminator:"")
            default:print("0", terminator:"")
            }
            //print(item, terminator:"")
            
        }
    }
}
