//
//  WordViewModelTests.swift
//  WordViewModelTests
//
//  Created by Moe Steinmueller on 01.06.22.
//

import XCTest
@testable import Werdd

class WordViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWordViewModel() {
        let result = Result(definition: "well expressed and to the point", partOfSpeech: nil, synonyms: ["well-chosen"], antonyms: ["unhappy"], examples: ["a happy turn of phrase"])
        let singleResult = SingleResult(uuid: UUID(), word: "happy", result: result)
        let wordViewModel = WordViewModel(word: singleResult)

        XCTAssertEqual(singleResult.word, wordViewModel.word)
        XCTAssertEqual(singleResult.result?.definition, wordViewModel.result?.definition)
        XCTAssertEqual(singleResult.result?.partOfSpeech, wordViewModel.result?.partOfSpeech)
        
    }
    
    func testWordViewModelNoResult() {
        let singleResult = SingleResult(uuid: UUID(), word: "lala", result: nil)
        let wordViewModel = WordViewModel(word: singleResult)
        
        XCTAssertEqual(singleResult.result, wordViewModel.result)
        XCTAssertNil(wordViewModel.result)
    }
}