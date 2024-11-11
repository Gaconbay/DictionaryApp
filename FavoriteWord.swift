//
//  FavoriteWord.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/8/24.
//
import Foundation
import SwiftData

@Model
final class FavoriteWord {
    var word: String
    
    init(word: String) {
        self.word = word
    }
}
