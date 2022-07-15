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

}
