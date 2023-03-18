//
//  File.swift
//  
//
//  Created by Carlyn Maw on 3/12/23.
//  based on C++ code from https://www.youtube.com/watch?v=6-0UaeJBumA

import Foundation

public extension NoiseMaker {
    static func makeSeedArray(size count:Int) -> [Double] {
        (1...count).map{ _ in  Double.random(in: 0...1) }
    }
    
    //TODO: COUNT MUST BE A POWER OF 2, fix that or add checking.
    //good enough locally coherent noise
    static func blurredRandomArray(count:Int, octaves uOct:Int, scalingBias:Double) -> [Double] {
        //TODO: Handle negative bias?
        let bias = max(scalingBias, 0.02)
        let octaves = uOct // TODO: catch is octave resolution is fine for count?
        var noiseArray:[Double] = []
        noiseArray.reserveCapacity(count)
        //let seedArray = (1...count).map{ _ in arc4random() }
        let seedArray = Self.makeSeedArray(size: count)
        //print(seedArray)
        for currentIndex in 0..<count {
            
            var noise = 0.0
            var scaleForOctave = 1.0
            
            var scaleAccumulator = 0.0
//            var caleAcc = 0.0

            for octave in 0..<octaves {
                
                //each octave point is half of the previous octave, starting with the width, i.e. the count
                //this function requires that the loop always be a power of two.
                let pitch = count >> octave
                //print("index: \(currentIndex), octave:\(octave), pitch:\(pitch)")
                if pitch == 0 { break } // TODO: see above catch is octave resolution is fine for count?
                let firstSampleIndex = currentIndex/pitch * pitch //snap to valid lower index for pitch
                let secondSampleIndex = (firstSampleIndex + pitch) % count //wrap if off the end
                
                //linear interpolation of where our currentIndex is between the two points
                let subSampleBlend = Double(currentIndex - firstSampleIndex) / Double(pitch)
                let octaveSample = (1.0 - subSampleBlend) * seedArray[firstSampleIndex] + subSampleBlend * seedArray[secondSampleIndex]
                
                noise += octaveSample * scaleForOctave
                scaleAccumulator += scaleForOctave
                scaleForOctave = scaleForOctave / bias
            }
            
            noiseArray.append(noise/scaleAccumulator) //keep it between 0 and 1
        }
        return noiseArray
    }
    
    //WIDTH must be power of two
    static func blurredRandomBuffer2D(width:Int, height:Int, octaves uOct:Int, scalingBias:Double) -> Buffer2D<Double> {
        //TODO: Handle negative bias?
        let bias = max(scalingBias, 0.02)
        let outputCount = width * height
        let octaves = uOct // TODO: catch is octave resolution is fine for count?
        var noiseArray:[Double] = []
        noiseArray.reserveCapacity(outputCount)
        //let seedArray = (1...count).map{ _ in arc4random() }
        let seedArray = Self.makeSeedArray(size: outputCount)
        //print(seedArray)
        for x in 0..<width {
            for y in 0..<height {
                
                var noise = 0.0
                var scaleForOctave = 1.0
                
                var scaleAccumulator = 0.0
                //            var caleAcc = 0.0
                
                for octave in 0..<octaves {
                    
                    //each octave point is half of the previous octave, starting with the width, i.e. the count
                    //this function requires that the loop always be a power of two.
                    let pitch = width >> octave
                    if pitch == 0 { break } // TODO: see above catch is octave resolution is fine for count?
                    let firstSampleX = x/pitch * pitch //snap to valid lower index for pitch
                    let firstSampleY = y/pitch * pitch //snap to valid lower index for pitch
                    
                    
                    let secondSampleX = (firstSampleX + pitch) % width //wrap if off the end
                    let secondSampleY = (firstSampleY + pitch) % width
                    
                    //linear interpolation of where our point is between the two points
                    let blendForX = Double(x - firstSampleX) / Double(pitch) //x percent
                    let blendForY = Double(y - firstSampleY) / Double(pitch) //y percent
                    
                    //octaveSampleT is the "Top" row
                    let topRowContribution = (1.0 - blendForX) * seedArray[indexForPoint(x: firstSampleX, y: firstSampleY, width: width)] + blendForX * seedArray[indexForPoint(x: secondSampleX, y: firstSampleY, width: width)]
                    let bottomRowContribution =  (1.0 - blendForX) * seedArray[indexForPoint(x: firstSampleX, y: secondSampleY, width: width)] + blendForX * seedArray[indexForPoint(x: secondSampleX, y: secondSampleY, width: width)]

                    //linear interp between rows
                    noise += (blendForY * (bottomRowContribution - topRowContribution) + topRowContribution) * scaleForOctave
                    scaleAccumulator += scaleForOctave
                    scaleForOctave = scaleForOctave / bias
                }
            
            
            noiseArray.append(noise/scaleAccumulator) //keep it between 0 and 1
            }
        }
        return Buffer2D(values: noiseArray, width: width)
        
    }
    
    //TODO: the one attached to buffer2D requires a type to use the static methods? Why?
    private static func indexForPoint(x:Int, y:Int, width:Int) -> Int {
        (y * width) + x
    }
}
