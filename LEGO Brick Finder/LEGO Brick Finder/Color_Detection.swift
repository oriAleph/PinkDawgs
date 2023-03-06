//
//  Color_Detection.swift
//  LEGO Brick Finder
//
//  Created by Izzy Cast on 2/28/23.
//

import Foundation
import SwiftUI
import UIKit

//Not implemented
struct Lego_Color{
    let legoNum: Int?
    let color_name: String?
    let redValue: Int?
    let greenValue: Int?
    let blueValue: Int?

}

//Not implemented
struct Collection{
    var collection: [Lego_Color]?
}


class Color_Detection{
    
    let cgImage = get_img?.cgImage
    var colorCollection = Collection()
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
    let legoBlack = Lego_Color(legoNum: 26, color_name: "Black", redValue: 27, greenValue: 42, blueValue: 52)
    let legoRed = Lego_Color(legoNum: 21, color_name: "Bright Red", redValue: 196, greenValue: 40, blueValue: 27)
    let legoBlue = Lego_Color(legoNum: 23, color_name: "Bright Blue", redValue: 13, greenValue: 105, blueValue: 171)
    
    
    //Get Pixel Values
    
//    var pixelData = CGDataProviderCopyData(CGImageGetDataProvider(get_img??.cgImage))
    /*
     Meant to load csv file with rgb colors
     Not currrently implemented
     */
    func LoadColors(){
        
//        let fm = FileManager.default
//
////        let path =
//
//        //READ IN FILE
//        let data = fm.contents(atPath: "/Users/izzyc/Desktop/PinkDawgs/LEGO Brick Finder/LEGO Brick Finder/RGB_Colors.csv")
//
//        let dir = try? fm.contentsOfDirectory(atPath: "./Applications")
//
////        print("Current Directory: \(dir)")
//
//        if(data != nil){
//            print("File Located!")
//        }
//        else{
//            print("File Not Found!")
//        }
//        do{
//            let content = try String(contentsOf: path)
//        }
//        catch{
//            print("Error Loading File!")
//        }
        

        
        //create color structures
        
    }
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
        
//        LoadColors()
        
        let bytesPerPixel = Double(cgImage!.bitsPerPixel) / Double(cgImage!.bitsPerComponent)
//        print("bitsPerPixel: \(cgImage!.bitsPerPixel), bitsPerComponent: \(cgImage!.bitsPerComponent)")
        //loop through image
        for y in 0...cgImage!.height{
            for x in 0...cgImage!.width{
                
                //Checking every other 10 pixels
                let x_value = x * 10
                let y_value = y * 10
                

                
                if(x_value < cgImage!.width && y_value < cgImage!.height){
                    
                    let offset = (y_value * cgImage!.bytesPerRow)  + (x_value * Int(bytesPerPixel))
                    let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
                    

                    //print("x[\(x_value)]y[\(y_value)]: \(components)")
                        
                    //component in color range "red component in Red range"
                    var redInRedRange: Bool?
                    var greenInRedRange: Bool?
                    var blueInRedRange: Bool?
                    
                    var redInBlueRange: Bool?
                    var greenInBlueRange: Bool?
                    var blueInBlueRange: Bool?
    
                    //check for red pixel
                    if(components.r >= redRedLimits.0 && components.r <= redRedLimits.1){
                        redInRedRange = true
                        //print("x[\(x_value)]y[\(y_value)]: \(components)")
                    }
                    if(components.g >= redGreenLimits.0 && components.g <= redGreenLimits.1){
                        greenInRedRange = true
                        //print("Green in Range: \(fallsInGreenRange ?? false)")
                    }
                    if(components.b >= redBlueLimits.0 && components.b <= redBlueLimits.1){
                        blueInRedRange = true
                        //print("Blue in Range: \(fallsInBlueRange ?? false)")
                    }
                    
                    //check for blue pixel
                    if(components.r >= blueRedLimits.0 && components.r <= blueRedLimits.1){
                        redInBlueRange = true
                        //print("x[\(x_value)]y[\(y_value)]: \(components)")
                    }
                    if(components.g >= blueGreenLimits.0 && components.g <= blueGreenLimits.1){
                        greenInBlueRange = true
                        //print("Green in Range: \(fallsInGreenRange ?? false)")
                    }
                    if(components.b >= blueBlueLimits.0 && components.b <= blueBlueLimits.1){
                        blueInBlueRange = true
                        //print("Blue in Range: \(fallsInBlueRange ?? false)")
                    }
                    
                    //if all three components fall in a specified range
                    if(redInRedRange ?? false && blueInRedRange ?? false && greenInRedRange ?? false){
                        return legoRed.color_name!
                        
                    }
    
                    if(redInBlueRange ?? false && blueInBlueRange ?? false && greenInBlueRange ?? false){
                        return legoBlue.color_name!
                        
                    }

                    
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
