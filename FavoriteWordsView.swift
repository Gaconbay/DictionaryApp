//
//  FavoriteWordsView.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/7/24.
//
import SwiftUI

struct FavoriteWordsView: View {
    @Binding var favoriteWords: [String]

    var body: some View {
        NavigationView {
            List(favoriteWords, id: \.self) { word in
                Text(word)
            }
            .navigationTitle("Favorite Words")
        }
    }
}

struct FavoriteWordsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteWordsView(favoriteWords: .constant(["apple", "banana", "cherry"]))
    }
}
