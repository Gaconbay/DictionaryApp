
//
//  FavoriteWordsManager.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/7/24.
//
import Foundation

class FavoriteWordsManager: ObservableObject {
    @Published var favoriteWords: [String] = []

    func addToFavorites(_ word: String) {
        guard favoriteWords.contains(word) == false else { return }
        favoriteWords.append(word)
    }
}
