//
//  DictionaryAppApp.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/2/24.
//
import SwiftUI
import SwiftData

@main
struct DictionaryAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FavoriteWord.self)
    }
}
