//
//  Lego_Color.swift
//  LEGO Brick Finder
//
//  Created by Izzy Cast on 4/17/23.
//

import Foundation

class Lego_Color{
    let colorName: String?
    let redValue: Int?
    let greenValue: Int?
    let blueValue: Int?
    var marginError: Int?
    
    init(){
        self.colorName = ""
        self.redValue = -1
        self.greenValue = -1
        self.blueValue = -1
        self.marginError = 0
    }

    init(colorName: String, redValue: Int, greenValue: Int, blueValue: Int, marginError: Int){
        self.colorName = colorName
        self.redValue = redValue
        self.greenValue = greenValue
        self.blueValue = blueValue
        self.marginError = marginError
    }
}
