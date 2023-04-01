//  Upload_Image.swift

import Foundation
import SwiftUI
import UIKit

var voiceOverEnabled = UIAccessibility.isVoiceOverRunning

struct Upload_Image_View: View {
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    var body: some View {
        
        VStack {
            
            Image(uiImage: self.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 300)
                .clipShape(Rectangle())
                .overlay(Rectangle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding([.top], 20)
                .accessibilityHidden(true)
            
            Spacer()
            Button(action: {self.isShowPhotoLibrary = true})
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
            .accessibilityHint(Text("Pulls up photos library"))
            
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
            }
            .padding([.bottom], 66)
            .accessibilityHint(Text("Shows Result screen"))
            
            Spacer()
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .navigationBarTitle("Upload Image", displayMode: .inline)
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                // 7.
                withAnimation {
                    self.isShowPhotoLibrary = true
                }
            }
        }
    }
}
