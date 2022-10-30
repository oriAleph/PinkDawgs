//
//  Search.swift
//  LEGO Brick Finder
//
//  Created by 00000000 on 10/16/22.
//

import Foundation
import SwiftUI

/*
struct Search_View: View {
    let countries = ["Afghanistan", "Albania", "Algeria", "Angola", "Argentia", "Armenia", "Australia", "Austria"]

    @State private var searchString = ""
    
    var body: some View {
        ZStack
        {
            VStack
            {
                List {
                    ForEach(searchString == "" ? countries: countries.filter { $0.contains(searchString)}, id: \.self) { country in
                                    Text(country)
                                }
                            }
                            .searchable(text: $searchString)
            }
            .navigationBarTitle("Search", displayMode: .inline)
        }
    }
}
*/

struct Search_View: View {
    
    @State var searchText = ""
    @State var searching = false
    
    let myFruits = [
        "Apple 🍏", "Banana 🍌", "Blueberry 🫐", "Strawberry 🍓", "Avocado 🥑", "Cherries 🍒", "Mango 🥭", "Watermelon 🍉", "Grapes 🍇", "Lemon 🍋"
    ]
    
    var body: some View {
            VStack(alignment: .leading) {
                SearchBar(searchText: $searchText, searching: $searching)
                List {
                    ForEach(myFruits.filter({ (fruit: String) -> Bool in
                        return fruit.hasPrefix(searchText) || searchText == ""
                    }), id: \.self) { fruit in
                        NavigationLink(destination: Result_View())
                        {
                            HStack {
                                Text(fruit)
                            }
                            .frame(width: 308, height: 74)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold,
                                          design: .default))
                            .cornerRadius(10)
                        }
                    }
                }
                    .listStyle(GroupedListStyle())
                    .toolbar {
                        if searching {
                            Button("Cancel") {
                                searchText = ""
                                withAnimation {
                                   searching = false
                                   UIApplication.shared.dismissKeyboard()
                                }
                            }
                        }
                    }
                    .gesture(DragGesture()
                                .onChanged({ _ in
                        UIApplication.shared.dismissKeyboard()
                                })
                    )
            }
            .navigationBarTitle("Search", displayMode: .inline)
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightGray"))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
    }
}


extension UIApplication {
     func dismissKeyboard() {
         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
 }
