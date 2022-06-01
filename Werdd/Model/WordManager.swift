//
//  WordManager.swift
//  Werdd
//
//  Created by Moe Steinmueller on 14.04.22.
//

import Foundation
import UIKit
//import Combine



protocol WordManegerDelegate {
    func didUpdateWord(_ wordManager: WordManager, word: SingleResult)
    func didUpdateTableView(_ wordManager: WordManager, word: Word)
    func didFailWithError(error: Error?, random: Bool)
}


struct WordManager {
    
    var delegate: WordManegerDelegate?
    let apiKey = WORDSAPI_KEY
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    //    private var cancellable: AnyCancellable?
    //    let session: URLSession
    //
    //    init(urlSession: URLSession = .shared) {
    //            self.session = urlSession
    //        }
    
    func fetchInputWord(inputWord: String) {
        let trimmed = inputWord.trimmingCharacters(in: .whitespacesAndNewlines)
        let convertedUrlQuery = trimmed.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        let urlString = "https://wordsapiv1.p.rapidapi.com/words/\(convertedUrlQuery)"
        
        guard let url = URL(string: urlString)  else {
            return
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("wordsapiv1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        urlRequest.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let word = try JSONDecoder().decode(Word.self, from: data)

                if let _ = word.results {
                    self.delegate?.didUpdateTableView(self, word: word)
                } else {
                    self.delegate?.didFailWithError(error: error, random: false)
                }
                
                
            } catch {
                self.delegate?.didFailWithError(error: error, random: false)
                print("Failed to convert \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchRandomWord() {
        let urlString = "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions"
        
        guard let url = URL(string: urlString)  else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("wordsapiv1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        urlRequest.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let word = try JSONDecoder().decode(Word.self, from: data)
                let randomResult = word.results?.randomElement()
                let singleResult = SingleResult(uuid: UUID(), word: word.word, result: randomResult)
                
                self.delegate?.didUpdateWord(self, word: singleResult)
                
            } catch {
                self.delegate?.didFailWithError(error: error, random: true)
                print("Failed to convert \(error.localizedDescription)")
            }
        }.resume()
    }
}
