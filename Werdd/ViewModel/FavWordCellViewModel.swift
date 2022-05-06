//
//  FavWordCellViewModel.swift
//  Werdd
//
//  Created by Moe Steinmueller on 06.05.22.
//

import Foundation

struct FavWordCellViewModel {
    private var favWordDetail: FavWord
    
    var wordName: String {
        return favWordDetail.word
    }
    
    var partOfSpeech: String? {
        return favWordDetail.partOfSpeech
    }
    
    var definition: String? {
        return favWordDetail.definition
    }
    
    init(favWordDetail: FavWord) {
        self.favWordDetail = favWordDetail
    }
}
