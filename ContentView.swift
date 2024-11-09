//
//  ContentView.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/2/24.
//
import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var definitions: [String] = []
    @ObservedObject private var searchHistory = SearchHistory()
    @State private var showSearchHistory = false
    @State private var showFavoriteWords = false // Declare and initialize showFavoriteWords
    @ObservedObject private var favoriteWordsManager = FavoriteWordsManager()

    var body: some View {
        NavigationView {
            VStack {
                TextField("English Dictionary", text: $searchText, onCommit: fetchDefinitions)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                List(definitions, id: \.self) { definition in
                    Text(definition)
                }
                Button("History",systemImage: "clock") {
                    showSearchHistory.toggle()
                }
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.borderedProminent)
                .tint(.primary)
                
                Button("Favorites", systemImage: "star.fill"){
                    showFavoriteWords.toggle()
                }
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.borderedProminent)
                .tint(.primary)
                
                Button("Add to Favorites", systemImage: "star"){
                    favoriteWordsManager.addToFavorites(searchText)
                }
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.borderedProminent)
                .tint(.primary)
            
            }
            .navigationTitle("Dictionary")
            .sheet(isPresented: $showSearchHistory) {
                SearchHistoryView(searchHistory: searchHistory)
            }
            .sheet(isPresented: $showFavoriteWords) {
                FavoriteWordsView(favoriteWords: $favoriteWordsManager.favoriteWords)
            }
        }
    }

    func fetchDefinitions() {
        DictionaryAPI.fetchDefinitions(searchText: searchText) { definitions in
            DispatchQueue.main.async {
                self.definitions = definitions
                self.searchHistory.addSearchTerm(self.searchText)
            }
        }
    }
}

#Preview{
    ContentView()
}
