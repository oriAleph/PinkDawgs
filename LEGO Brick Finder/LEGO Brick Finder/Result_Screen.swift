//
//  Result_Screen.swift
//  LEGO Brick Finder
//
//  Created by 00000000 on 10/15/22.
//

import Foundation
import SwiftUI
import UIKit


struct Result_View: View {
    var body: some View {
        ZStack
        {
            VStack
            {
                Spacer()
                
                Text("Name:")
                .font(.system(size: 30, weight: .bold,
                                           design: .default))
                Text("(Insert Brick Name Here)")
                
                Spacer()
                
                Text("Color:")
                .font(.system(size: 30, weight: .bold,
                                           design: .default))
                Text("(Insert Color Name Here)")
                
                Spacer()
            }
            .navigationBarTitle("Results", displayMode: .inline)
        }
    }
}
