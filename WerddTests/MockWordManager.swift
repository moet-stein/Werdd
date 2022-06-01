//
//  MockWordManager.swift
//  WerddTests
//
//  Created by Moe Steinmueller on 01.06.22.
//

import Foundation
import XCTest

@testable import Werdd

final class MockWordManager: NetWorkingProtocol {
    
    func fetchRandomWord(completion: @escaping (Swift.Result<SingleResult, Error>) -> Void) {

        if let path = Bundle.main.path(forResource: "WordResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decodedObject = try JSONDecoder().decode(Word.self, from: data)
                let randomResult = decodedObject.results?.randomElement()
                completion(.success(SingleResult(uuid: UUID(), word: decodedObject.word, result: randomResult)))
            } catch {
                completion(.failure(error))
                print("Failed to convert \(error.localizedDescription)")
            }
        }
    }
    
    func fetchInputWord(inputWord: String, completion: @escaping (Swift.Result<Word, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "WordResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decodedObject = try JSONDecoder().decode(Word.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
                print("Failed to convert \(error.localizedDescription)")
            }
        }
    }
    
    
//    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
//
//        override class func canInit(with request: URLRequest) -> Bool {
//            return true
//        }
//
//        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
//            return request
//        }
//
//        override func startLoading() {
//            guard let handler = MockWordManager.requestHandler else {
//                XCTFail("Received unexpected request with no handler set")
//                return
//            }
//            do {
//                let (response, data) = try handler(request)
//                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
//                client?.urlProtocol(self, didLoad: data)
//                client?.urlProtocolDidFinishLoading(self)
//            } catch {
//                client?.urlProtocol(self, didFailWithError: error)
//            }
//        }
//
//        override func stopLoading() {
//        }

}
