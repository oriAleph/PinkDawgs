//
//  Color_Detection.swift
//  LEGO Brick Finder
//
//  Created by Izzy Cast on 2/28/23.
//

import Foundation
import SwiftUI
import UIKit

class Color_Detection{
    
    let cgImage = get_img?.cgImage
    var colorCollection = Lego_Color_Collection()
    var red: Int = 0
    var green: Int = 0
    var blue: Int = 0
    
    //Color Ranges
    
    //Red Color Limits
    let redRedLimits = (166, 226)
    let redGreenLimits = (10,70)
    let redBlueLimits = (0,57)
    
    //Black Color Limits
    let blackRedRanges = 7...47
    let blackGreenRanges = 22...62
    let blackBlueRanges = 32...72
    
    //Blue Color Limits
    let blueRedLimits = (0,43)
    let blueGreenLimits = (75,135)
    let blueBlueLimits = (141,201)
    
    
    //Creating lego_color objects
    let legoBlack = Lego_Color(
        colorName: "Black",
        redValue: 27,
        greenValue: 42,
        blueValue: 52,
        marginError: 0)
    let legoRed = Lego_Color(
        colorName: "Bright Red",
        redValue: 196,
        greenValue: 40,
        blueValue: 27,
        marginError: 0)
    let legoBlue = Lego_Color(
        colorName: "Bright Blue",
        redValue: 13,
        greenValue: 105,
        blueValue: 171,
        marginError: 0)
    

    /*
     function:      results
     paramaters:    N/A
     returns:       A string representing the name of the color identified
     */
    func results() -> (String) {
       
        guard let data = cgImage?.dataProvider?.data,
              let bytes = CFDataGetBytePtr(data)
        else{
            fatalError("Couldn't access image data")
        }
        
        let marginOfError = 20
        var colorDetected = Lego_Color()
        
        colorCollection.LoadColors()
        colorCollection.PrintColors()
        
        var colorsInRange = [Lego_Color]()

        let bytesPerPixel = Double(cgImage!.bitsPerPixel) / Double(cgImage!.bitsPerComponent)
//        print("bitsPerPixel: \(cgImage!.bitsPerPixel), bitsPerComponent: \(cgImage!.bitsPerComponent)")
        //loop through image
        for y in 0...cgImage!.height where y % 5 == 0{
            for x in 0...cgImage!.width where x % 5 == 0{
                
                //Checking every other 10 pixels
//                let x_value = x * 3
//                let y_value = y * 3
                

                
                if(x < cgImage!.width && y < cgImage!.height){
                    
                    let offset = (y * cgImage!.bytesPerRow)  + (x * Int(bytesPerPixel))
                    let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
                    
                    
                    var redIndex = colorCollection.FindIndex(low: 0, high: colorCollection.arraySize - 1, key: Int(components.r))
                    
                    print("*********Index: \(redIndex)")
                    
                    colorsInRange = colorCollection.QualifyRedComponent(startingIndex: redIndex, range: marginOfError, matchedRedValue: Int(components.r))
                    
                    //colorsInRange = colorCollection.QualifyGreenAndBlue(RedQualifiers: colorsInRange, range: marginOfError, curPixelGreen: Int(components.g), curPixelBlue: Int(components.b))
                    
                    colorDetected = colorCollection.QualifyGreenAndBlue(RedQualifiers: colorsInRange, range: marginOfError,curPixelRed: Int(components.r), curPixelGreen: Int(components.g), curPixelBlue: Int(components.b))
                    
                    if(colorDetected.redValue != -1){
                        return colorDetected.colorName!
                        }
                    
//                    if(!colorsInRange.isEmpty){
//
//                        return colorsInRange[0].colorName ?? "Error color name"
//
//                    }
                    
                    //Int(components.r)
                    
                    //print("x[\(x_value)]y[\(y_value)]: \(components)")
                    
                        
                    //component in color range "red component in Red range"
//                    var redInRedRange: Bool?
//                    var greenInRedRange: Bool?
//                    var blueInRedRange: Bool?
//
//                    var redInBlueRange: Bool?
//                    var greenInBlueRange: Bool?
//                    var blueInBlueRange: Bool?
//
//                    //check for red pixel
//                    if(components.r >= redRedLimits.0 && components.r <= redRedLimits.1){
//                        redInRedRange = true
//                        //print("x[\(x_value)]y[\(y_value)]: \(components)")
//                    }
//                    if(components.g >= redGreenLimits.0 && components.g <= redGreenLimits.1){
//                        greenInRedRange = true
//                        //print("Green in Range: \(fallsInGreenRange ?? false)")
//                    }
//                    if(components.b >= redBlueLimits.0 && components.b <= redBlueLimits.1){
//                        blueInRedRange = true
//                        //print("Blue in Range: \(fallsInBlueRange ?? false)")
//                    }
//
//                    //check for blue pixel
//                    if(components.r >= blueRedLimits.0 && components.r <= blueRedLimits.1){
//                        redInBlueRange = true
//                        //print("x[\(x_value)]y[\(y_value)]: \(components)")
//                    }
//                    if(components.g >= blueGreenLimits.0 && components.g <= blueGreenLimits.1){
//                        greenInBlueRange = true
//                        //print("Green in Range: \(fallsInGreenRange ?? false)")
//                    }
//                    if(components.b >= blueBlueLimits.0 && components.b <= blueBlueLimits.1){
//                        blueInBlueRange = true
//                        //print("Blue in Range: \(fallsInBlueRange ?? false)")
//                    }
//
//                    //if all three components fall in a specified range
//                    if(redInRedRange ?? false && blueInRedRange ?? false && greenInRedRange ?? false){
//                        return legoRed.colorName!
//
//                    }
//
//                    if(redInBlueRange ?? false && blueInBlueRange ?? false && greenInBlueRange ?? false){
//                        return legoBlue.colorName!
//
//                    }

                    
//                    if(components.r  < 30){
//                        if(components.g > 30 && components.g < 70 ){
//                            if(components.b > 180 && components.b < 250 ){
//
//                              print("x[\(x)]y[\(y)]: \(components)")
//                                print("(\(x),\(y))")
//                            }
//                        }
//                    }
                }
            }
        }

        return "No Color Identified"
    }
}
