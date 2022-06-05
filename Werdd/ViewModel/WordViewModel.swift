//
//  WordViewModel.swift
//  Werdd
//
//  Created by Moe Steinmueller on 01.06.22.
//

import Foundation
import UIKit

struct WordViewModel {
    let uuid: UUID
    let word: String
    let result: Result?
    let definition: String //no optional
    let partOfSpeech: UIImage?
    let hidePOS: Bool

    init(word: SingleResult) {
        self.uuid = word.uuid
        self.word = word.word
        self.result = word.result
        
        if let result = result {
            if let partOfSpeech = result.partOfSpeech {
                self.partOfSpeech = UIImage(named: partOfSpeech)
                self.hidePOS = false
            } else {
                self.partOfSpeech = nil
                self.hidePOS = true
            }
            
            self.definition = result.definition ?? ""
        } else {
            self.partOfSpeech = nil
            self.hidePOS = true
            self.definition = ""
        }
        
    }
}
