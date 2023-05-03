//
//  TestRNG.swift
//  
//
//  Created by Carlyn Maw on 5/2/23.
//

//Sequence: https://github.com/apple/swift/blob/1ba25d05c4bcff190aab521173b55d51b8e45e9f/stdlib/public/core/Sequence.swift
//LazySequence: https://github.com/apple/swift/blob/1ba25d05c4bcff190aab521173b55d51b8e45e9f/stdlib/public/core/LazySequence.swift
//RandomNumberGenerator: https://github.com/apple/swift/blob/1ba25d05c4bcff190aab521173b55d51b8e45e9f/stdlib/public/core/Random.swift

//Random unification discussion: https://github.com/apple/swift/pull/16413

import Foundation


struct NotARandomNumberGenerator:RandomNumberGenerator {
    var last_value:UInt64 = 1
    
    mutating func next()  -> UInt64 {
        let tmp = last_value
        last_value = last_value + 1
        return tmp
    }
}
