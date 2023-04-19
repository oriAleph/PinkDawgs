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

    /*
     function:      results: Iterates through the input image coparing it's pixels to a list of Lego_Colors
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
//        colorCollection.PrintColors()
        
        var colorsInRange = [Lego_Color]()

        let bytesPerPixel = Double(cgImage!.bitsPerPixel) / Double(cgImage!.bitsPerComponent)
//        print("bitsPerPixel: \(cgImage!.bitsPerPixel), bitsPerComponent: \(cgImage!.bitsPerComponent)")
        //loop through image
        for y in 0...cgImage!.height where y % 5 == 0{
            for x in 0...cgImage!.width where x % 5 == 0{
                
                if(x < cgImage!.width && y < cgImage!.height){
                    
                    let offset = (y * cgImage!.bytesPerRow)  + (x * Int(bytesPerPixel))
                    let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
                    
                    //Find current pixel's index within color collection based on it's red component
                    var redIndex = colorCollection.FindIndex(low: 0, high: colorCollection.arraySize - 1, key: Int(components.r))
                    
//                    print("*********Index: \(redIndex)")
                    //Fill array with possible matches based on it's red component
                    colorsInRange = colorCollection.QualifyRedComponent(startingIndex: redIndex, range: marginOfError, matchedRedValue: Int(components.r))
                    //Check green and blue components for a match with the least margin of error
                    colorDetected = colorCollection.QualifyGreenAndBlue(RedQualifiers: colorsInRange, range: marginOfError,curPixelRed: Int(components.r), curPixelGreen: Int(components.g), curPixelBlue: Int(components.b))
                    //check for detected color
                    if(colorDetected.redValue != -1){
                        return colorDetected.colorName!
                        }
                }
            }
        }

        return "No Color Identified"
    }
}
