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
    func didFailWithError(error: Error, random: Bool)
}


struct WordManager {    
    var delegate: WordManegerDelegate?
    
    func fetchInputWord(inputWord: String, spinner: UIActivityIndicatorView) {
        let urlString = "https://wordsapiv1.p.rapidapi.com/words/\(inputWord)"
        
        performRequest(with: urlString, random: false, spinner: spinner)
    }
    
    func fetchRandomWord(spinner: UIActivityIndicatorView) {
        let urlString = "https://wordsapiv1.p.rapidapi.com/words/?random=true"
        
        performRequest(with: urlString, random: true, spinner: spinner)
    }

    
    func performRequest(with urlString: String, random: Bool, spinner: UIActivityIndicatorView) {
        if let url = URL(string: urlString) {
            
            let apiKey = WORDSAPI_KEY
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("wordsapiv1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
            urlRequest.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
            
            spinner.startAnimating()
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let word = try JSONDecoder().decode(Word.self, from: data)
                    
                    random ? self.delegate?.didUpdateWord(self, word: word) : self.delegate?.didUpdateTableView(self, word: word)
                    
                    print(word)
                } catch {
                    random ? self.delegate?.didFailWithError(error: error, random: true) : self.delegate?.didFailWithError(error: error, random: false)
                    print("Failed to convert \(error.localizedDescription)")
                }
            }.resume()
            
        }
        
    }
}
