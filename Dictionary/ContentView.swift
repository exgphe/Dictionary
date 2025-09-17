//
//  ContentView.swift
//  Dictionary
//
//  Created by Xiaolin Wang on 09/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Search…", text: $searchText)
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
                .padding()
                .glassEffect(.regular.interactive())
                .transition(.opacity.combined(with: .scale))
                .overlay {
                    if !searchText.isEmpty {
                        HStack {
                            Spacer()
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                            }
                                .accessibilityLabel("Clear Search")
                                .foregroundColor(.secondary)
                                .padding(.trailing, 20)
                        }
                    }
                }
                .onSubmit {
                    withAnimation {
                        isSearching = true
                    }
                }
                .popover(isPresented: $isSearching, arrowEdge: .bottom) {
                    DictionaryView(searchText: searchText).ignoresSafeArea(.all)
                }
        }.padding()
    }
}

#Preview {
    ContentView()
}
