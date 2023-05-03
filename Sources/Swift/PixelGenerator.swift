//
//  PixelGenerator.swift
//
//
//  Created by Carlyn Maw on 4/19/23.
//

//https://github.com/apple/swift/blob/1ba25d05c4bcff190aab521173b55d51b8e45e9f/stdlib/public/core/Random.swift
//While the system generator is automatically seeded and thread-safe on every platform, the cryptographic quality of the stream of random data produced by the generator may vary. For more detail, see the documentation for the APIs used by each platform.
//Apple platforms use arc4random_buf(3).
//Linux platforms use getrandom(2) when available; otherwise, they read from /dev/urandom.
//Windows uses BCryptGenRandom.
//var g = SystemRandomNumberGenerator()


import Foundation

//TODO: would for _ in 0..<multWH be faster for those functions that are all random?

struct PixelGenerator {
    //Note, if want this to be an instance variable, PixelGenerator will need
    //to be a class.
    static private(set) var generator = SystemRandomNumberGenerator()
    
    static func randomByte() -> UInt8 {
        UInt8.random(in: 0...UInt8.max, using: &generator)
    }
    
    static func random32Bit() -> UInt32 {
        UInt32.random(in: 0...UInt32.max, using: &generator)
    }

    
    static func purple_pixels(width:Int, height:Int, includeAlpha:Bool = false) -> [UInt8] {
        var pixelData:[UInt8] = []
        if includeAlpha {
            for _ in 0..<height {
                for _ in 0..<width {
                    pixelData.append(0x77)
                    pixelData.append(0x00)
                    pixelData.append(randomByte())
                    pixelData.append(0xFF)
                }
            }
        } else {
            for _ in 0..<height {
                for _ in 0..<width {
                    pixelData.append(0x77)
                    pixelData.append(0x00)
                    pixelData.append(randomByte())
                }
            }
        }

        return pixelData
    }
    
    // static func purple_pixels_RGB8(width:Int, height:Int) -> [UInt8] {
    //     var pixelData:[UInt8] = []
    //     for _ in 0..<height {
    //         for _ in 0..<width {
    //             pixelData.append(0x77)
    //             pixelData.append(0x00)
    //             pixelData.append(randomByte())
    //         }
    //     }
    //     return pixelData
    // }
    
    static func truecolor_random8(width:Int, height:Int, includeAlpha:Bool = false) -> [UInt8] {
        var pixelData:[UInt8] = []
        
        if includeAlpha {
            for _ in 0..<height {
                for _ in 0..<width {
                    pixelData.append(randomByte())
                    pixelData.append(randomByte())
                    pixelData.append(randomByte())
                    pixelData.append(randomByte())
                }
            }
        }
        else {
            for _ in 0..<height {
                for _ in 0..<width {
                    pixelData.append(randomByte())
                    pixelData.append(randomByte())
                    pixelData.append(randomByte())
                }
            }
        }
        return pixelData
    }
    
    static func truecolor_random32(width:Int, height:Int) -> [UInt8] {
        var pixelData:[UInt8] = []
        
        for _ in 0..<height {
            for _ in 0..<width {
                pixelData.append(contentsOf: random32Bit().bytes)
            }
        }
        return pixelData
    }
    
    static func grayscale_random8(width:Int, height:Int, includeAlpha:Bool = false) -> [UInt8] {
        var pixelData:[UInt8] = []
        let count = height * width
        if includeAlpha {
            for _ in 0..<count {
                pixelData.append(randomByte())
                pixelData.append(randomByte())
            }
        }
        else {
            for _ in 0..<count {
                pixelData.append(randomByte())
            }
        }
        return pixelData
    }
    
    static func grayscale_verticalStripe(width:Int, height:Int) -> [UInt8] {
        var pixelData:[UInt8] = []
        
        for _ in 0..<height {
            for i in 0..<width {
                if i % 3 == 0 {
                    pixelData.append(0x00)
                } else if (i+1) % 3 == 0 {
                    pixelData.append(0xFF)
                } else {
                    pixelData.append(randomByte())
                }
            }
        }
        return pixelData
    }
    
    static func grayscale_randomAlphaTest(width:Int, height:Int) -> [UInt8] {
        var pixelData:[UInt8] = []
        
        for _ in 0..<height {
            for i in 0..<width {
                if i % 3 == 0 {
                    pixelData.append(0x00)
                    pixelData.append(randomByte())
                } else if (i+1) % 3 == 0 {
                    pixelData.append(0xFF)
                    pixelData.append(randomByte())
                } else {
                    pixelData.append(randomByte())
                    pixelData.append(0xFF)
                }
            }
        }
        return pixelData
    }
    
}
