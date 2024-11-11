//
//  ContentView.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/2/24.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var searchText = ""
    @State private var definitions: [String] = []
    @ObservedObject private var searchHistory = SearchHistory()
    @State private var showSearchHistory = false
    @State private var showFavoriteWords = false
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteWords: [FavoriteWord]
    
    var body: some View {
        HStack (){
            Text("Dictionary")
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .padding()
        
        VStack {
            TextField("English Dictionary", text: $searchText, onCommit: fetchDefinitions)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
            
        HStack {
            Button("Add to Favorites", systemImage: "star") {
                addToFavorites()
            }
            .disabled(searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.borderedProminent)
            .tint(.primary)   
            .padding(.horizontal, 15)
            Spacer()
        }
            
            List(definitions, id: \.self) { definition in
                Text(definition)
            }
        
        
        HStack {
            Button("History", systemImage: "clock") {
                showSearchHistory.toggle()
            }
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.borderedProminent)
            .tint(.primary)
            
            Button("Favorites", systemImage: "star.fill") {
                showFavoriteWords.toggle()
            }
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.borderedProminent)
            .tint(.primary)
        }
        .navigationTitle("Dictionary")
        .opacity(showSearchHistory || showFavoriteWords ? 0.1 : 1)
        
        .sheet(isPresented: $showSearchHistory) {
            SearchHistoryView(searchHistory: searchHistory)
        }
        .sheet(isPresented: $showFavoriteWords) {
            FavoriteWordsView()
        }
    }
    
    func addToFavorites() {
        if !favoriteWords.contains(where: { $0.word == searchText }) || favoriteWords.isEmpty {
            let newFavorite = FavoriteWord(word: searchText)
            modelContext.insert(newFavorite)
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

#Preview {
    ContentView()
        .modelContainer(for: FavoriteWord.self, inMemory: true)
}
