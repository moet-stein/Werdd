//
//  WordManager.swift
//  Werdd
//
//  Created by Moe Steinmueller on 14.04.22.
//

import Foundation
protocol WordManegerDelegate {
    func didUpdateWord(_ wordManager: WordManager, word: Word)
    func didUpdateTableView(_ wordManager: WordManager, word: Word)
    func didFailWithError(error: Error)
}


struct WordManager {    
    var delegate: WordManegerDelegate?
    
    func fetchInputWord(inputWord: String) {
        let urlString = "https://wordsapiv1.p.rapidapi.com/words/\(inputWord)"
        
        performRequest(with: urlString, random: false)
    }
    
    func fetchRandomWord() {
        let urlString = "https://wordsapiv1.p.rapidapi.com/words/?random=true"
        
        performRequest(with: urlString, random: true)
    }

    
    func performRequest(with urlString: String, random: Bool) {
        if let url = URL(string: urlString) {
            
            let apiKey = WORDSAPI_KEY
            
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
                    
                    random ? self.delegate?.didUpdateWord(self, word: word) : self.delegate?.didUpdateTableView(self, word: word)
                    
                    print(word)
                } catch {
                    print("Failed to convert \(error.localizedDescription)")
                }
            }.resume()
        }
        
    }
    
    
    func parseJSON(_ wordData: Data) -> Word? {
        let decoder = JSONDecoder()
        do {
            let decodedDdata = try decoder.decode(Word.self, from: wordData)
            let word = decodedDdata.word
            let results = decodedDdata.results
            let frequency = decodedDdata.frequency
            
            let wordData = Word(word: word, results: results, frequency: frequency)
            return wordData
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
