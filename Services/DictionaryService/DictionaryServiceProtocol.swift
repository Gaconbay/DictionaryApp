//
//  DictionaryServiceProtocol.swift
//  DictionaryApp
//
//  Created by Ty Tran on 12/1/24.
//
import Foundation
//import SwiftData

protocol DictionaryServiceProtocol {
    func fetchDefinition(for word: String) async throws -> [DictionaryResponse]
}
