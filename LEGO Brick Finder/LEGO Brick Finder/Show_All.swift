//
//  Show_All.swift
//  LEGO Brick Finder
//
//  Created by 00000000 on 10/16/22.
//

import Foundation
import SwiftUI

struct Show_All_View: View {
    var body: some View {
        ZStack
        {
            VStack
            {
                ScrollView(showsIndicators: false)
                {
                    ForEach(0..<100) { i in
                        NavigationLink(destination: Result_View())
                        {
                            HStack {
                                Text("Brick Name \(i)")
                            }
                            .frame(width: 308, height: 74)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold,
                                          design: .default))
                            .cornerRadius(10)
                            //.padding([.bottom], 66)
                        }
                    }
                }
            }
            .navigationBarTitle("Show All", displayMode: .inline)
        }
    }
}
