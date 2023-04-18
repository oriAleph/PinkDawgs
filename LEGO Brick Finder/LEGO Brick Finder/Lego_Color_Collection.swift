//
//  Lego_Color_Collection.swift
//  LEGO Brick Finder
//
//  Created by Izzy Cast on 4/17/23.
//

import Foundation

class Lego_Color_Collection{
    var collection: [Lego_Color]?
    var colorArray = [Lego_Color]()
    var arraySize = 0
    init(){}
    
    func QualifyRedComponent(startingIndex: Int, range: Int, matchedRedValue: Int ) -> [Lego_Color]{
        
        print("*****QualifyRedComponent(): \(startingIndex)")
        
        var index = startingIndex
        let upperLimit = matchedRedValue + range
        let lowerLimit = matchedRedValue - range
        var possibleColors = [Lego_Color]()
        
        print("     Range: \(range) UpperLimit: \(upperLimit) LowerLimit: \(lowerLimit)")
        print("     Starting Index: \(colorArray[startingIndex].redValue)")
        
        //red values less than the starting index
        while(index >= 0 && colorArray[index].redValue ?? 0 >= lowerLimit ){
                
            print("     Lower Values")
            colorArray[index].marginError = abs(startingIndex - (colorArray[index].redValue ?? 0))
                possibleColors.append(colorArray[index])
                index -= 1
            
        }
        
        index = startingIndex
        
        //red values greater than the starting index
        while(index <= (arraySize - 1) && colorArray[index].redValue ?? 0 <= upperLimit ){
                
            print("     Upper Values")
                possibleColors.append(colorArray[index])
                index += 1
            
        }
        
        return possibleColors

    }
    
    func FindIndex(low: Int, high: Int, key: Int) -> (Int){
        var lowIndex = low
        var highIndex = high
        
        var counter = 0
        
//        print("*****FindIndex(): Key Value: \(key) Low Value: \(lowIndex) Hight Value: \(highIndex)")
        
        while(lowIndex <= highIndex && counter < 100){
            
//            print("     Low: \(lowIndex) High: \(highIndex)")
            
            if (highIndex - lowIndex == 1 || highIndex == lowIndex) {return lowIndex}

            let midPoint = ((highIndex - lowIndex) / 2) + lowIndex
            
//            print("     MidPoint: \(midPoint)")
            
            //key is less than midpoint
            if(key < colorArray[midPoint].redValue ?? -1){
                
//                print("     Key is less than midPoint Key: \(key) MidPoint: \(String(describing: colorArray[midPoint].redValue))")
                highIndex = midPoint - 1
            }
            //key is greater than midpoint
            else if(key > colorArray[midPoint].redValue ?? -1 ){
                lowIndex = midPoint + 1
//                print("     Key is greater than midPoint Key: \(key) MidPoint: \(String(describing: colorArray[midPoint].redValue))")
            }
            else{
                return midPoint
            }
            
            counter += 1
//            print("Counter: \(counter)")
//            print("LowIndex: \(lowIndex) HighIndex: \(highIndex) MidPoint: \(midPoint)")
        }
        
        print("No Index found!")
        return -1
    }
    
    func LoadColors(){
        
        let path = Bundle.main.url(forResource: "Sampled_Colors",withExtension: "csv")
        
        var contents: String?
        do{
            contents = try String(contentsOf: path!)
//            print(contents ?? "No Content")
            
            //segment 'contents' into records and insert them into the binary search tree
        }catch{
            print("File Error: File \(String(describing: path)) not loaded!")
        }
        
        let rows = contents?.components(separatedBy: "\n")
        
        for row in rows!{
            
            let columns = row.components(separatedBy: ",")
            
            if columns.count == 4{
                
                let colorName = columns[0]
                let redComponent = Int(columns[1])
                let greenComponent = Int(columns[2])
                var tempBlueComponent = columns[3]
                
                tempBlueComponent = tempBlueComponent.trimmingCharacters(in: .whitespacesAndNewlines)
                
                let blueComponent = Int(tempBlueComponent)
                
//                print("blueComponent: \(blueComponent ?? -1)")
//
//                print("column[3]: \(columns[3])")
//                print("")
//                print("colorName \(colorName)")
//                print("     redComponent \(redComponent ?? -1)")
//                print("     greenComponent \(greenComponent ?? -1)")
//                print("     blueComponent: \(String(describing: blueComponent))" )
//                print("")
                
                let newLegoColor = Lego_Color(colorName: colorName, redValue: redComponent ?? -1, greenValue: greenComponent ?? -1, blueValue: blueComponent ?? -5, marginError: 0)
                
                colorArray.append(newLegoColor)
                arraySize += 1
                
            }
        }
        
    }
    
    func QualifyGreenAndBlue(RedQualifiers: [Lego_Color], range: Int,curPixelRed: Int, curPixelGreen: Int, curPixelBlue: Int) -> Lego_Color{
        
        //var QualifiedColors = [Lego_Color]()
        
        print("*****QualifyGreenAndBlue(): Range: \(range) Red: \(curPixelRed) Green: \(curPixelGreen) Blue \(curPixelBlue)")
        
                print("+++++Color In Range:+++++")
        
                for items in RedQualifiers{
        
                    print(" ColorName: \(items.colorName ?? "None") redValue: \(items.redValue ?? -1)")
//                    items.marginError = 0
        
                }
        
                print("+++++End of Colors+++++")
        
        let upperGreen = curPixelGreen + range
        let lowerGreen = curPixelGreen - range
        
        let upperBlue = curPixelBlue + range
        let lowerBlue = curPixelBlue - range
        
        print("upperGreen: \(upperGreen) lowerGreen: \(lowerGreen)")
        print("upperBlue: \(upperBlue) lowerBlue: \(lowerBlue)")
        
        var lowestMarginError = 0
        var tempError = 0
        
        var colorDetected = Lego_Color()
        
        tempError = abs((RedQualifiers[0].redValue ?? 0) - curPixelRed)
        tempError += abs((RedQualifiers[0].greenValue ?? 0) - curPixelGreen)
        tempError += abs((RedQualifiers[0].blueValue ?? 0) - curPixelBlue)
        lowestMarginError = (RedQualifiers[0].marginError ?? 0) + tempError
        
        print(      "lowestMarginError: \(lowestMarginError)")
        
        for color in RedQualifiers{
            
            color.marginError = 0
            tempError = abs((color.redValue ?? 0) - curPixelRed)
            tempError += abs((color.greenValue ?? 0) - curPixelGreen)
            tempError += abs((color.blueValue ?? 0) - curPixelBlue)
            color.marginError! += tempError
            
            print("Color Name: \(color.colorName) Red: \(color.redValue) Green: \(color.greenValue) Blue: \(color.blueValue)")
                        
            if((color.greenValue ?? 0) > lowerGreen && (color.greenValue ?? 0) < upperGreen){
                print(" Passes Green Threshold")
                
                if((color.blueValue ?? 0) > lowerBlue && (color.blueValue ?? 0) < upperBlue){
                    print("     Passes Blue Threshold")
                    print("     Color Margin Error: \(color.marginError) current Low Margin: \(lowestMarginError)")
                    if(color.marginError ?? 0 < lowestMarginError){
                        print("         Passes Lower Threshold")
                        //QualifiedColors.append(color)
                        colorDetected = color
                        lowestMarginError = color.marginError!
                        print("         current Color: \(color.colorName ?? "Error: color name")")
                        print("         current LowestMarginError: \(lowestMarginError)")
                        
                    }
                }
            }
        }
        
        return colorDetected
    }
    
    func PrintColors(){
        
        for items in colorArray{
            
            print("Color Name: \(String(describing: items.colorName)) Red:\(String(describing: items.redValue)) Green: \(String(describing: items.greenValue)) Blue: \(String(describing:items.blueValue ))")
            
        }
        
        
        
    }
}
