//
//  WordsViewModel.swift
//  Werdd
//
//  Created by Moe Steinmueller on 06.05.22.
//

import Foundation


struct WordsViewModel {
    
    var words: [SingleResult]?
    
    var numberOfRowsInSection: Int {
        return words?.count ?? 1
    }
    
    init(words: [SingleResult]?) {
        self.words = words
    }
    
    mutating func wordToSingleResults(from word: Word) {
        
        if let results = word.results{
            for result in results {
                words?.append(SingleResult(word: word.word, result: result))
            }
        }  else {
            words?.append(SingleResult(word: word.word, result: nil))
        }
    }
}
