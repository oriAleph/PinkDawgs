//  ContentView.swift

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack
        {
            NavigationView
            {
                VStack
                {
                    
                    NavigationLink(destination: Capture_Image_View())
                    {
                        HStack {
                            Text("Capture Image")
                                .padding([.trailing], 35)
                            Image("Camera")
                                .renderingMode(.original)
                                .frame(width: 53, height: 42)
                        }
                        .frame(width: 308, height: 74)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold,
                                      design: .default))
                        .cornerRadius(10)
                        
                    }
                    .padding([.top], 66)
                    .padding([.bottom], 66)
                    
                    NavigationLink(destination: Upload_Image_View())
                    {
                        HStack {
                            Text("Upload Image")
                                .padding([.trailing], 35)
                            Image("Folder")
                                .renderingMode(.original)
                                .frame(width: 53, height: 42)
                        }
                        .frame(width: 308, height: 74)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold,
                                      design: .default))
                        .cornerRadius(10)
                    }
                    .padding([.bottom], 66)
                    
                    NavigationLink(destination: Search_View())
                    {
                        HStack {
                            Text("Search")
                                .padding([.leading], 50)
                            
                            Image("Glass")
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
                    
                    NavigationLink(destination: About())
                    {
                        HStack {
                            Text("About")
                                .padding([.leading], 50)
                            Image("File")
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
                    
                    Button(action: {
                        if let yourURL = URL(string: "https://www.youtube.com") {
                        UIApplication.shared.open(yourURL, options: [:], completionHandler: nil)
                    }})
                    {
                        HStack {
                            Text("Tutorial")
                                .padding([.leading], 50)
                                
                            Image("Youtube")
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
                    
                    
                    
                    Spacer()
                }
                .navigationBarTitle("LEGO Brick Finder", displayMode: .inline)
            }
        }
    }
}

