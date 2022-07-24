//
//  WordManager.swift
//  Werdd
//
//  Created by Moe Steinmueller on 14.04.22.
//

import Foundation
import UIKit
import Combine

enum NetworkError: LocalizedError, Equatable {
    case badURL
    case noDataReturned
}

protocol NetWorkingProtocol {
    func fetchGenericData<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (T?, NetworkError?) -> ())
}


class WordManager: NetWorkingProtocol {
    let apiKey = WORDSAPI_KEY
    var successCount = 0
    var failureCount = 0
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    let session: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    func fetchGenericData<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (T?, NetworkError?) -> ()) {

        guard let url = URL(string: urlString)  else {
            self.failureCount += 1
            completion(nil, NetworkError.badURL)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("wordsapiv1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        urlRequest.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")

        session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, NetworkError.noDataReturned)
                return
            }

            do {
                self.successCount += 1
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj, nil)

            } catch {
                completion(nil, NetworkError.noDataReturned)
                print("Failed to convert \(error.localizedDescription)")
            }
        }.resume()
    }
}
