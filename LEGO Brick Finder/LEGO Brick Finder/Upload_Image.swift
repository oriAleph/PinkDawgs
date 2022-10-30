//
//  Upload_Image.swift
//  LEGO Brick Finder
//
//  Created by 00000000 on 10/15/22.
//

import Foundation
import SwiftUI
import UIKit


struct Upload_Image_View: View {
    @State private var image: Image? = Image("camera")
    @State private var shouldPresentImagePicker = true
    @State private var shouldPresentCamera = false
    
    
    var body: some View {
        ZStack
        {
                VStack
                {
                    image!
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .clipShape(Rectangle())
                                .overlay(Rectangle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .sheet(isPresented: $shouldPresentImagePicker) {
                                    SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
                                    }
                                .padding([.top], 20)
                    Spacer()
                    
                    Button(action: {self.shouldPresentImagePicker = true})
                    {
                        HStack {
                            Text("Redo")
                                .padding([.leading], 50)
                            
                            Image("Redo")
                                .renderingMode(.original)
                                .frame(width: 53, height: 42)
                                .padding([.leading], 50)
                        }
                        .frame(width: 308, height: 74)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold,
                                      design: .default))
                        .cornerRadius(10)
                        
                    }
                    .padding([.bottom], 66)
                    
                    NavigationLink(destination: Result_View())
                    {
                        HStack {
                            Text("Confirm")
                                .padding([.leading], 35)
                            Image("Check")
                                .renderingMode(.original)
                                .frame(width: 53, height: 42)
                                .padding([.leading], 50)
                        }
                        .frame(width: 308, height: 74)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold,
                                      design: .default))
                        .cornerRadius(10)
                        .padding([.bottom], 66)
                    }
                    
                    Spacer()
                }
                .navigationBarTitle("Upload Image", displayMode: .inline)
        }
    }
}
