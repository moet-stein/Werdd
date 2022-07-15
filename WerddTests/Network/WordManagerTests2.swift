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
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        //Arrange
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        //Act
        sut.fetchGenericData(urlString: "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions", type: Word.self) { (fetchresponse) in
            XCTAssertEqual(self.sut.successCount, 1, "SucessCount should equal to 1 but it did not match")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }

}
