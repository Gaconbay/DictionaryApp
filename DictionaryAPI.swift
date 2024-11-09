//
//  DictionaryAPI.swift
//  DictionaryApp
//
//  Created by Ty Tran on 11/7/24.
//
import Foundation

class DictionaryAPI {
    static func fetchDefinitions(searchText: String, completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(searchText)") else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                if let meanings = json?.first?["meanings"] as? [[String: Any]] {
                    let definitions = meanings.flatMap { ($0["definitions"] as? [[String: Any]])! }
                        .compactMap { $0["definition"] as? String }
                    completion(definitions)
                } else {
                    completion([])
                }
            } catch {
                completion([])
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
}
