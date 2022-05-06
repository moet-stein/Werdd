//
//  WordsCellViewModel.swift
//  Werdd
//
//  Created by Moe Steinmueller on 06.05.22.
//

import Foundation

struct WordCellViewModel {
    private var wordDetail: SingleResult
    
    var wordName: String {
        return wordDetail.word
    }
    
    var partOfSpeech: String? {
        return wordDetail.result?.partOfSpeech
    }
    
    var definition: String? {
        return wordDetail.result?.definition
    }
    
    init(wordDetail: SingleResult) {
        self.wordDetail = wordDetail
    }
}
