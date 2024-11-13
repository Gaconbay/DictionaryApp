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
        .border(.red, width: 3)
        
        VStack {
            TextField("English Dictionary", text: $searchText, onCommit: fetchDefinitions)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
        .border(.red, width: 2)
        
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
        .border(.red, width: 3)
        
        List(definitions, id: \.self) { definition in
            Text(definition)
        }
        .border(.red, width: 3)
        
        
        HStack {
            Button("History", systemImage: "clock.fill") {
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
        .border(.red, width: 3)
        .opacity(showSearchHistory || showFavoriteWords ? 0.1 : 1)
        
        .sheet(isPresented: $showSearchHistory) {
            SearchHistoryView(searchHistory: searchHistory)
        }
        .sheet(isPresented: $showFavoriteWords) {
            FavoriteWordsView()
        }
        TabView {
            
            
        }
        .padding(.horizontal)
        .border(.red, width: 3)
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
