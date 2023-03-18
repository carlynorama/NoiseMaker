//
//  File.swift
//  
//
//  Created by Carlyn Maw on 3/12/23.
//

import Foundation
import CNoiseMaker

public extension NoiseMaker {
    //TODO: CFloat to Double, pitfalls? Size differences?
    static func perlinWrapper(x:Double, y:Double) -> Double {
        Double(perlin(CFloat(x), CFloat(y)))
    }
    
}
