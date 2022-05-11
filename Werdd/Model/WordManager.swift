//
//  WordManager.swift
//  Werdd
//
//  Created by Moe Steinmueller on 14.04.22.
//

import Foundation
import UIKit



protocol WordManegerDelegate {
    func didUpdateWord(_ wordManager: WordManager, word: Word)
    func didUpdateTableView(_ wordManager: WordManager, word: Word)
    func didFailWithError(error: Error?, random: Bool)
}




struct WordManager {
    
    var delegate: WordManegerDelegate?
    
//    var singleResults: [SingleResult] = [SingleResult]()
    
    func fetchInputWord(inputWord: String) {
        let trimmed = inputWord.trimmingCharacters(in: .whitespacesAndNewlines)
        let convertedUrlQuery = trimmed.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        let urlString = "https://wordsapiv1.p.rapidapi.com/words/\(convertedUrlQuery)"
        
        performRequest(with: urlString, random: false)
    }
    
    func fetchRandomWord() {
        let urlString = "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions"
        
        performRequest(with: urlString, random: true)
    }

    
    func performRequest(with urlString: String, random: Bool) {
        if let url = URL(string: urlString) {
            
            let apiKey = WORDSAPI_KEY
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("wordsapiv1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
            urlRequest.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
            
            URLSession.shared.dataTask(with: urlRequest) {data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let word = try JSONDecoder().decode(Word.self, from: data)
                    random ? self.delegate?.didUpdateWord(self, word: word) : self.delegate?.didUpdateTableView(self, word: word)

                } catch {
                    random ? self.delegate?.didFailWithError(error: error, random: true) : self.delegate?.didFailWithError(error: error, random: false)
                    print("Failed to convert \(error.localizedDescription)")
                }
            }.resume()
            
        }
        
    }
    
//    func wordToSingleResults(inputWord: Word) -> [SingleResult] {
//
//        var words = [SingleResult]()
//
//        if let results = inputWord.results{
//            for result in results {
//                words.append(SingleResult(word: inputWord.word, result: result))
//            }
//            return words
//        }  else {
//            return [SingleResult(word: inputWord.word, result: nil)]
//        }
//    }
}
