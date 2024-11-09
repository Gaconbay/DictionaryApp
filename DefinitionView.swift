//
//  DefinitionView.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/7/24.
//
import SwiftUI

struct DefinitionView: View {
    let searchTerm: String

    var body: some View {
        VStack {
            Text("Definition of \(searchTerm)")
            // Add code to fetch and display the definition of the search term here
        }
        .navigationTitle("Definition")
    }
}
