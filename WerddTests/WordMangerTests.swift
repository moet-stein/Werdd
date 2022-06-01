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
    
    func testFetchedWordSuccess() {
        
        homeVC.wordManager.fetchRandomWord(completion: { result in
            switch result {
            case .success(let word):
                XCTAssertEqual(word.word, "swift")
                
            case .failure:
               print("fail")
            }
        })
    }

}
