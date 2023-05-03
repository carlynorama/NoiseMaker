//
//  UInt32+bytes.swift
//
//
//  Created by Carlyn Maw on 4/24/23.
//

import Foundation


extension UInt32 {
    var b0:UInt8 {
        return UInt8(self & 0xFF)
    }
    
    var b1:UInt8 {
        return UInt8((self >> 8) & 0xFF)
    }
    
    var b2:UInt8 {
        return UInt8((self >> 16) & 0xFF)
    }
    
    var b3:UInt8 {
        return UInt8((self >> 24) & 0xFF)
    }
}
extension FixedWidthInteger {
    var bytes:[UInt8] {
        get {
            withUnsafeBytes(of: self) {
                return Array($0)
            }
        }
        set {
            self = newValue.withUnsafeBytes { (bytes) -> Self in
                bytes.load(as: Self.self)
            }
            
        }
    }
}
