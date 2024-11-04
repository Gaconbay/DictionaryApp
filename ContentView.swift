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

    var body: some View {
        NavigationView {
            VStack {
                TextField("English Dictionary", text: $searchText, onCommit: fetchDefinitions)
                /**onCommit or onSubmit{}**/
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                List(definitions, id: \.self) { definition in
                    Text(definition)
                }
            }
            .navigationTitle("Dictionary")
        }
    }

    func fetchDefinitions() {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(searchText)") else { return }
        

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                if let meanings = json?.first?["meanings"] as? [[String: Any]] {
                    self.definitions = meanings.flatMap { ($0["definitions"] as? [[String: Any]])! }
                        .compactMap { $0["definition"] as? String }
                    DispatchQueue.main.async {
                        // Update UI on the main thread
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }


}


#Preview{
    ContentView()
}
