//
//  DetailsViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class DetailsViewController: UIViewController {
    private var contentView: DetailsView!
    private var wordVM: WordViewModel?
    
    private var favoriteButton: IconButton!
    
    private var favWordID = UUID()
    
    override func loadView() {
        contentView = DetailsView(selectedWord: wordVM)
        view = contentView
        
        favoriteButton = contentView.favoriteButton
        
        addButtonTarget()
        setUpContent()
    }
    
    init(selectedWord: WordViewModel?) {
        self.wordVM = selectedWord
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addButtonTarget() {
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }
    
    private func setUpContent() {
        if let selectedWord = wordVM {
            contentView.setUpDetailsViewContent(word: selectedWord)
            checkWordFavInCoreData(word: selectedWord.word, definition: selectedWord.definition)
        }
    }
    
    private func checkWordFavInCoreData(word: String, definition: String?) {
        if let definition = definition {
            DataManager.fetchFavWord(usingDefinition: definition) { word in
                if let foundWord = word {
                    DispatchQueue.main.async { [weak self] in
                        self?.favoriteButton.isSelected = true
                        self?.favoriteButton.toggleFavorite()
                    }
                    favWordID = foundWord.uuid
                }
            }
        } else {
            DataManager.fetchFavWord(usingWord: word) { word in
                if let foundWord = word {
                    DispatchQueue.main.async { [weak self] in
                        self?.favoriteButton.isSelected = true
                        self?.favoriteButton.toggleFavorite()
                    }
                    favWordID = foundWord.uuid
                }
            }
        }
        
    }
    
    @objc func favoriteTapped(sender: UIButton) {
        let button = sender as! IconButton
        
        sender.isSelected = !sender.isSelected
        
        button.toggleFavorite()
        
        if let selectedWord = wordVM {
            if sender.isSelected {
                let word = selectedWord.word
                let definition = selectedWord.definition
                let partOfSpeech = selectedWord.result?.partOfSpeech
                let synonyms = selectedWord.result?.synonyms
                let antonyms = selectedWord.result?.antonyms
                let examples = selectedWord.result?.examples
                
                DataManager.createFavWord(word: word, definition: definition, partOfSpeech: partOfSpeech, synonyms: synonyms, antonyms: antonyms, examples: examples, id: favWordID)
            } else {
                print(favWordID)
                DataManager.deleteFavWord(usingID: favWordID)
            }
        }
        
    }
}
