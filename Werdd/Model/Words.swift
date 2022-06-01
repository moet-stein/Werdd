//
//  Words.swift
//  Werdd
//
//  Created by Moe Steinmueller on 16.03.22.
//

import Foundation

struct SingleResult {
    var uuid: UUID
    var word: String
    var result: Result?
}

struct Word: Codable {
    var word: String
    var results: [Result]?
}

struct Result: Codable {
    var definition: String?
    var partOfSpeech: String?
    var synonyms: [String]?
    var antonyms: [String]?
    var examples: [String]?
}
