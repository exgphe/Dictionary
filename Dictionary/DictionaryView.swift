//
//  DictionaryView.swift
//  Dictionary
//
//  Created by Xiaolin Wang on 09/06/2025.
//
import SwiftUI

struct DictionaryView: UIViewControllerRepresentable {
    let searchText: String
    
    func makeUIViewController(context: Context) -> UIReferenceLibraryViewController {
        UIReferenceLibraryViewController(term: searchText)
    }
    
    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: Context) {
        // No update needed for this view controller
    }
}
