//
//  searchHistoryView.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/7/24.
//
import SwiftUI

struct SearchHistoryView: View {
    @ObservedObject var searchHistory: SearchHistory
    @State private var selectedTerm: String?
    
    var body: some View {
        NavigationView {
            VStack {
                List(searchHistory.history, id: \.self) { word in
                    Text(word)
                }
                Spacer()
                VStack {
                    Button("Remove all") {
                        searchHistory.clearHistory()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle)
                    .tint(.red)
                }
                
            }
            .navigationTitle("Search History")
        }
    }
}


#Preview {
    @Previewable @State var searchHistory = SearchHistory()
    SearchHistoryView(searchHistory: searchHistory)
}
