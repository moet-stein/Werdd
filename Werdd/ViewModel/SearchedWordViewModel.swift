//
//  SearchedWordViewModel.swift
//  Werdd
//
//  Created by Moe Steinmueller on 01.06.22.
//

import Foundation

struct SearchedWordViewModel {
    let word: String
    let result: Result?
    let definition: String?
    let partOfSpeech: String?

    init(words: SingleResult) {
        self.word = words.word
        self.result = words.result
        
        if let result = result {
            if let pOSpeech = result.partOfSpeech {
                partOfSpeech = pOSpeech
            } else {
                partOfSpeech = ""
            }
            
            if let def = result.definition {
                definition = def
            } else {
                definition = ""
            }
        } else {
            partOfSpeech = nil
            definition = nil
        }
    }
}
