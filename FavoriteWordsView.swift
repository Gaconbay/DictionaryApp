//
//  FavoriteWordsView.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/7/24.
//
import SwiftUI
import SwiftData

struct FavoriteWordsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteWords: [FavoriteWord]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteWords) { favoriteWord in
                    Text(favoriteWord.word)
                }
                .onDelete(perform: deleteFavorites)
            }
            .navigationTitle("Favorite Words")
        }
    }
    
    private func deleteFavorites(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(favoriteWords[index])
        }
    }
}

#Preview {
    FavoriteWordsView()
        .modelContainer(for: FavoriteWord.self, inMemory: true)
}
