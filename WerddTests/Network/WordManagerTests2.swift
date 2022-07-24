//
//  WordManagerTests2.swift
//  WerddTests
//
//  Created by Moe Steinmueller on 15.07.22.
//

import XCTest
@testable import Werdd

class WordManagerTests2: XCTestCase {
    
    var sut: WordManager!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = WordManager(urlSession: urlSession)
    }

    override func tearDown() {
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testWordManager_WhenGivenValidURL_ReturnsSuccess() {
        //Arrange
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        //Act
        sut.fetchGenericData(urlString: "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions", type: Word.self) { (fetchresponse, error) in
            XCTAssertEqual(self.sut.successCount, 1, "SucessCount should equal to 1 but it did not match")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testWordManager_WhenEmptyURLStringProvided_RetrunsError() {
        //Arrange
        let expectation = self.expectation(description: "An empty request URL string expectaion")
        
        //Act
        sut.fetchGenericData(urlString: "", type: Word.self) { (fetchresponse, error) in
            
            //Assert
            XCTAssertEqual(error, NetworkError.badURL, "The fetchGenericData() method did not return an expected error for an badURL error")
            XCTAssertEqual(self.sut.failureCount, 1, "failureCount should equal to 1 but it did not match")
            XCTAssertNil(fetchresponse, "When an invalidRequestURLString takes place, the response model must be nil")
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 2)
    }
    
    func testWordManager_WhenGivenInputWordInvalid_ReturnsError() {
        let expectation = self.expectation(description: "An invalid search word inpput expectation")
        let inputWord = "zzz"
        
        sut.fetchGenericData(urlString: "https://wordsapiv1.p.rapidapi.com/words/\(inputWord)", type: Word.self) { (fetchresponse, error) in
            
            XCTAssertEqual(error, NetworkError.noDataReturned, "The fetchGenericData() did not return an expected error for a noDataReturned error")
            XCTAssertEqual(self.sut.failureCount, 1, "failureCount should equal to 1 but it did not match")
            XCTAssertNil(fetchresponse, "When an invalidRequestURLString takes place, the response model must be nil")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }

}
