//
//  searchHistory.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/7/24.
//
import Foundation
import Combine

class SearchHistory: ObservableObject {
    @Published private(set) var history: [String]

    private let userDefaultsKey = "searchHistory"

    init() {
        if let savedHistory = UserDefaults.standard.stringArray(forKey: userDefaultsKey) {
            self.history = savedHistory
        } else {
            self.history = []
        }
    }

    func addSearchTerm(_ term: String) {
        if !history.contains(term) {
            history.insert(term, at: 0)
            UserDefaults.standard.set(history, forKey: userDefaultsKey)
        }
    }
    
    func clearHistory() {
        history.removeAll()
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
