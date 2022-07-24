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
    
    func testFetchedWordShouldNotBeEmpty() {
        let expectation = self.expectation(description:  "testFetchedInputWordSuccess")
        var fetchedWord: [Word] = [Word]()
        
        homeVC.wordManager.fetchGenericData(urlString: "", type: [Word].self) { (result, error) in
            if let _ = error {
                XCTFail("Expected rooms list, but failed \(String(describing: error)).")
                return
            }
            
            if let word = result {
                fetchedWord = word
                expectation.fulfill()
            }
            
        }
        
        waitForExpectations(timeout: 5.0)
        
        XCTAssert(fetchedWord.count > 0, "word is empty")
    }
    
    func testWordCountShouldBeOne() {
        let expectation = self.expectation(description:  "testFetchedInputWordSuccess")
        var fetchedWord: [Word] = [Word]()
        
        homeVC.wordManager.fetchGenericData(urlString: "", type: [Word].self) { (result, error) in
            
            if let _ = error {
                XCTFail("Expected word, but failed \(String(describing: error)).")
                return
            }
            
            if let word = result {
                fetchedWord = word
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5.0)
        
        XCTAssert(fetchedWord.count == 1, "word count is NOT one")
    }
}
