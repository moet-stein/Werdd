//
//  DetailsViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class DetailsViewController: UIViewController {
    private var passedFavWord: FavWord?
    
    private var contentView: DetailsView!
    private var selectedWord: SingleResult?
    
    private var favoriteButton: IconButton!
    
    
    
    private var favWordID = UUID()
    private var justCreated = false
    
    override func loadView() {
        contentView = DetailsView(selectedWord: selectedWord)
        view = contentView
        
        favoriteButton = contentView.favoriteButton
        addButtonTarget()
        checkFavInCoreData()
    }
    
    init(passedFavWord: FavWord?, selectedWord: SingleResult?) {
        self.passedFavWord = passedFavWord
        self.selectedWord = selectedWord
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addButtonTarget() {
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }
    
    private func checkFavInCoreData() {
//        DataManager.fetchFavWord(usingWord: selectedWord.word, definition: selectedWord.result?.definition) { word in
//            guard let word = word else {
//                return
//            }
//            favWordID = word.uuid
//            
//            
//        }
    }
    
    @objc func favoriteTapped(sender: UIButton) {
        let button = sender as! IconButton
        
        sender.isSelected = !sender.isSelected
        
        button.toggleFavorite()
        
        if let selectedWord = selectedWord {
            if sender.isSelected {
                let word = selectedWord.word
                let definition = selectedWord.result?.definition
                let partOfSpeech = selectedWord.result?.partOfSpeech
                let synonyms = selectedWord.result?.synonyms
                let antonyms = selectedWord.result?.antonyms
                let examples = selectedWord.result?.examples
                
                DataManager.createFavWord(word: word, definition: definition, partOfSpeech: partOfSpeech, synonyms: synonyms, antonyms: antonyms, examples: examples, id: favWordID)
                justCreated = true
            } else {
                if justCreated {
                    DataManager.deleteFavWord(usingID: favWordID)
                }
    //            DataManager.deleteFavWord(word: selectedWord)
            }
        }
        
        if let passedFavWord = passedFavWord {
            print("favWord Passed")
        }
        
    }
    
    
    
    
    
}
