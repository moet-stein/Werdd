//
//  WordsViewModel.swift
//  Werdd
//
//  Created by Moe Steinmueller on 06.05.22.
//

import Foundation

//
//struct WordViewModel {
//    let wordManager = WordManager()
//    var results: [SingleResult] = [SingleResult(word: "")]
//
//    var randomWord: Word? {
//        didSet {
//            guard let safeWord = randomWord else {
//                return
//            }
//
//            results = wordToSingleResults()
//
//        }
//    }
//
////    var numberOfRowsInSection: Int {
////        return words?.count ?? 1
////    }
////
////    init(words: [SingleResult]?) {
////        self.words = words
////    }
//
//    mutating func wordToSingleResults(inputWord: String?) -> [SingleResult] {
//
//        var words = [SingleResult]()
//
//        if let inputWord = inputWord {
//            wordManager.fetchInputWord(inputWord: inputWord)
//            self.randomWord = wordManager.fetchedWord
//        }
//
//        if let results = randomWord?.results{
//            for result in results {
//                words.append(SingleResult(word: randomWord?.word, result: result))
//            }
//            return words
//        }  else {
//            return [SingleResult(word: randomWord?.word, result: nil)]
//        }
//    }
//}
