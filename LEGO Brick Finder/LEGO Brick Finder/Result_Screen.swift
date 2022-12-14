// Result_Screen.swift

import Foundation
import SwiftUI
import UIKit


struct Result_View: View {
    var body: some View {
        ZStack
        {
            VStack
            {
                // MARK: - Inference
                let process = Image_Processing()

                let fieldName = process.results().0
                let info = process.results().1
                
                // MARK: - Display
                Spacer()
                
                Text("Name:")
                .font(.system(size: 30, weight: .bold,
                                           design: .default))
                
                Text("\(fieldName) - \(info)")
                
                Spacer()
                
                Text("Color:")
                .font(.system(size: 30, weight: .bold,
                                           design: .default))
                Text("(Insert Color and Score Here)")
                
                Spacer()
            }
            .navigationBarTitle("Results", displayMode: .inline)
        }
    }
}
