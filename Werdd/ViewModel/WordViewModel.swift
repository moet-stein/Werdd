//
//  WordViewModel.swift
//  Werdd
//
//  Created by Moe Steinmueller on 01.06.22.
//

import Foundation

struct WordViewModel {
    let uuid: UUID
    let word: String
    let result: Result?
    let definition: String?
    let partOfSpeech: String?

    init(word: SingleResult) {
        self.uuid = word.uuid
        self.word = word.word
        self.result = word.result
        
        if let result = result {
            partOfSpeech = result.partOfSpeech
            definition = result.definition
        } else {
            partOfSpeech = nil
            definition = nil
        }
    }
}
