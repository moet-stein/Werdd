//
//  WordViewModel.swift
//  Werdd
//
//  Created by Moe Steinmueller on 01.06.22.
//

import Foundation
import UIKit

struct WordViewModel {
    let uuid: UUID
    let word: String
    let result: Result?
    let definition: String
    let partOfSpeech: UIImage?
    let hidePOS: Bool
    let antonyms: [String]?
    let hideAntonyms: Bool
    let synonyms: [String]?
    let hideSynonyms: Bool
    let examples: [String]?
    let hideExamples: Bool
    
    init(word: SingleResult) {
        self.uuid = word.uuid
        self.word = word.word
        self.result = word.result
        
        guard let result = result else {
            self.partOfSpeech = nil
            self.hidePOS = true
            self.definition = ""
            self.antonyms = nil
            self.hideAntonyms = true
            self.synonyms = nil
            self.hideSynonyms = true
            self.examples = nil
            self.hideExamples = true
            return
        }
        
        self.definition = result.definition ?? ""
        
        if let partOfSpeech = result.partOfSpeech {
            self.partOfSpeech = UIImage(named: partOfSpeech)
            self.hidePOS = false
        } else {
            self.partOfSpeech = nil
            self.hidePOS = true
        }
        
        if let antonyms = result.antonyms {
            self.antonyms = antonyms
            self.hideAntonyms = false
        } else {
            self.antonyms = nil
            self.hideAntonyms = true
        }
        
        if let synonyms = result.synonyms {
            self.synonyms = synonyms
            self.hideSynonyms = false
        } else {
            self.synonyms = nil
            self.hideSynonyms = true
        }
        
        if let examples = result.examples {
            self.examples = examples
            self.hideExamples = false
        } else {
            self.examples = nil
            self.hideExamples = true
        }
        
        
    }
}
