//
//  WordMangerTests.swift
//  WerddTests
//
//  Created by Moe Steinmueller on 01.06.22.
//

import XCTest
@testable import Werdd

class WordMangerTests: XCTestCase {

    var homeVC: HomeViewController!

    override func setUp() {
        super.setUp()
        homeVC = HomeViewController(wordManager: MockWordManager())
    }
    
    override func tearDown() {
        super.tearDown()
        homeVC = nil
    }
    
    func testFetchedRandomWordSuccess() {
        homeVC.wordManager.fetchGenericData(urlString: "", type: Word.self) { result in
            switch result {
            case .success(let word):
                XCTAssertEqual(word.word, "swift")
                
            case .failure:
                print("fail")
            }
        }
    }
    
    func testFetchedInputWordSuccess() {
        let results = [
            Result(definition: "moving very fast", partOfSpeech: "adjective", synonyms: ["fleet"], antonyms: nil, examples: ["a swift current", "swift flight of an arrow", "a swift runner"]),
            Result(definition: "common western lizard; seen on logs or rocks", partOfSpeech: "noun", synonyms: ["blue-belly", "sceloporus occidentalis", "western fence lizard"], antonyms: nil, examples: nil),
            Result(definition: "United States meat-packer who began the use of refrigerated railroad cars (1839-1903)", partOfSpeech: "noun", synonyms: ["gustavus franklin swift"], antonyms: nil, examples: nil),
            Result(definition: "an English satirist born in Ireland (1667-1745)", partOfSpeech: "noun", synonyms: ["dean swift", "jonathan swift"], antonyms: nil, examples: nil),
            Result(definition: "a small bird that resembles a swallow and is noted for its rapid flight", partOfSpeech: "noun", synonyms: nil, antonyms: nil, examples: nil)
        ]
        
        homeVC.wordManager.fetchGenericData(urlString: "", type: Word.self) { result in
            switch result {
            case .success(let word):
                XCTAssertEqual(word.word, "swift")
                XCTAssertEqual(word.results, results)
            case .failure:
                print("fail")
            }
        }
    }
}
