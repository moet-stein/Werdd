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
    
    func testWordViewModelNilResult() {
        let singleResult = SingleResult(uuid: UUID(), word: "lala", result: nil)
        let wordViewModel = WordViewModel(word: singleResult)
        
        XCTAssertEqual(singleResult.result, wordViewModel.result)
        XCTAssertNil(wordViewModel.result)
    }
    
    
    func testWordViewModelDefinition() {
        let result = Result(definition: "light-sensitive paper on which photograph can be printed", partOfSpeech: "noun", synonyms: nil, antonyms: nil, examples: nil)
        let singleResult = SingleResult(uuid: UUID(), word: "photographic paper", result: result)
        let wordViewModel = WordViewModel(word: singleResult)
        
        XCTAssertEqual(wordViewModel.definition, "light-sensitive paper on which photograph can be printed", "light-sensitive paper on which photograph can be printed")
    }
    
    func testWordViewModelNoDefinition() {
        let result = Result(definition: nil, partOfSpeech: nil, synonyms: nil, antonyms: nil, examples: nil)
        let singleResult = SingleResult(uuid: UUID(), word: "bahaha", result: result)
        let wordViewModel = WordViewModel(word: singleResult)
        
        XCTAssertEqual(wordViewModel.definition, "", "wordViewModel expected empty string but failed")
    }
    
    func testWordViewModelPartOfSpeechUIImage() {
        let result = Result(definition: "light-sensitive paper on which photograph can be printed", partOfSpeech: "noun", synonyms: nil, antonyms: nil, examples: nil)
        let singleResult = SingleResult(uuid: UUID(), word: "photographic paper", result: result)
        let wordViewModel = WordViewModel(word: singleResult)
        
        XCTAssertEqual(wordViewModel.partOfSpeech, UIImage(named: "noun"), "not expected UIImage for wordViewMode")
    }
    
    func testWordViewModelPartOfSpeechUIImageNoImageFound() {
        let result = Result(definition: "light-sensitive paper on which photograph can be printed", partOfSpeech: "notRecognized", synonyms: nil, antonyms: nil, examples: nil)
        let singleResult = SingleResult(uuid: UUID(), word: "photographic paper", result: result)
        let wordViewModel = WordViewModel(word: singleResult)
        
        XCTAssertNil(wordViewModel.partOfSpeech)
    }
}
