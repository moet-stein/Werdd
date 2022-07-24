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

    func fetchGenericData<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (T?, NetworkError?) -> ()) {
        if let path = Bundle.main.path(forResource: "WordResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decodedObject = try JSONDecoder().decode(T.self, from: data)

                completion(decodedObject, nil)
            } catch {
                completion(nil, NetworkError.noDataReturned)
                print("Failed to convert \(error.localizedDescription)")
            }
        }
    }
}
