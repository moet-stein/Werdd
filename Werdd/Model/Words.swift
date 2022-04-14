//
//  Words.swift
//  Werdd
//
//  Created by Moe Steinmueller on 16.03.22.
//

import Foundation

class Words {
    let words: [WordDetail] = [
        Noun(word: "Programming", definition: "craeting a sequence of instructions to enable the computer to do something"),
        Adjective(word: "swift", definition: "moving or capable of moving with great speed or velocity"),
        Adjective(word: "happy", definition: "delighted, pleased, or glad, as over a particular thing"),
        Noun(word: "mindfulness", definition: "the state or quality of being mindful or aware of something"),
        Adjective(word: "colorful", definition: "richly eventful or picturesque"),
        Noun(word: "code", definition: "a system for communication by telegraph, heliograph, etc., in which long and short sounds, light flashes, etc., are used to symbolize the content of a message"),
        Noun(word: "confidence", definition: "full trust; belief in the powers, trustworthiness, or reliability of a person or thing"),
        Noun(word: "cookie", definition: "a small, usually round and flat cake, the size of an individual portion, made from stiff, sweetened dough, and baked"),
        Noun(word: "segregation", definition: "a setting apart or separation of people or things from others or from the main body or group"),
        Noun(word: "audit", definition: "an official examination and verification of accounts and records, especially of financial accounts"),
        Noun(word: "life", definition: "the animate existence or period of animate existence of an individual"),
        Noun(word: "sun", definition: "a star, especially one that has planets and other celestial bodies revolving around it"),
        Adverb(word: "quickly", definition: "with speed, rapidly, very soon"),
        Verb(word: "eat", definition: "to take into the mouth and swallow for nourishment; chew and swallow"),
        Verb(word: "live", definition: "to have life, as an organism; be alive; be capable of vital functions"),
        Noun(word: "island", definition: "a tract of land completely surrounded by water, and not large enough to be called a continent")
    ]
}

protocol WordDetail {
    var word: String { get }
    var category: String { get }
    var definition: String { get }
}

class Noun: WordDetail {
    var word: String
    var category: String = "noun"
    var definition: String
    
    init(word: String, definition: String) {
        self.word = word
        self.definition = definition
    }
}
 
class Adjective: WordDetail {
    var word: String
    var category: String = "adjective"
    var definition: String
    
    init(word: String, definition: String) {
        self.word = word
        self.definition = definition
    }
}

class Verb: WordDetail {
    var word: String
    var category: String = "verb"
    var definition: String
    
    init(word: String, definition: String) {
        self.word = word
        self.definition = definition
    }
}

class Adverb: WordDetail {
    var word: String
    var category: String = "adverb"
    var definition: String
    
    init(word: String, definition: String) {
        self.word = word
        self.definition = definition
    }
}

struct Word: Codable {
    var word: String
    var results: [Result]?
    var frequency: Double?
}

struct Result: Codable {
    var definition: String?
    var partOfSpeech: String?
    var synonyms: [String]?
    var antonyms: [String]?
    var examples: [String]?
}
