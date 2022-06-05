//
//  MockWordManager.swift
//  WerddTests
//
//  Created by Moe Steinmueller on 01.06.22.
//

import Foundation
import XCTest

@testable import Werdd

enum NetworkError: Error {
    case badURL
    case noDataReturned
}


final class MockWordManager: NetWorkingProtocol {
    func fetchGenericData<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (Swift.Result<T, Error>) -> ()) {
        if let path = Bundle.main.path(forResource: "WordResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
                print("Failed to convert \(error.localizedDescription)")
            }
        }
    }
    
    
//    func fetchRandomWord(completion: @escaping (Swift.Result<SingleResult, Error>) -> Void) {
//
//        if let path = Bundle.main.path(forResource: "WordResponse", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path))
//                let decodedObject = try JSONDecoder().decode(Word.self, from: data)
//                let randomResult = decodedObject.results?.randomElement()
//                completion(.success(SingleResult(uuid: UUID(), word: decodedObject.word, result: randomResult)))
//            } catch {
//                completion(.failure(error))
//                print("Failed to convert \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func fetchInputWord(inputWord: String, completion: @escaping (Swift.Result<Word, Error>) -> Void) {
//        if let path = Bundle.main.path(forResource: "WordResponse", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path))
//                let decodedObject = try JSONDecoder().decode(Word.self, from: data)
//
//                if decodedObject.word == inputWord {
//                    completion(.success(decodedObject))
//                } else {
//                    completion(.failure(NetworkError.noDataReturned))
//                }
//
//            } catch {
//                completion(.failure(error))
//                print("Failed to convert \(error.localizedDescription)")
//            }
//        }
//    }

}
