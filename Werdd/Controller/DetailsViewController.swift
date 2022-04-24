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
    
    private var wordLabel: UILabel!
    private var definitionLabel: UILabel!
    private var categoryLabel: UILabel!
    private var synonymsCard: DetailsCardView!
    private var antonymsCard: DetailsCardView!
    private var usageCard: DetailsCardView!
    
    private var favWordID = UUID()
    private var justCreated = false
    
    override func loadView() {
        contentView = DetailsView(selectedWord: selectedWord)
        view = contentView
        
        favoriteButton = contentView.favoriteButton
        wordLabel = contentView.wordLabel
        categoryLabel = contentView.categoryLabel
        definitionLabel = contentView.definitionLabel
        synonymsCard = contentView.synonymsCard
        antonymsCard = contentView.antonymsCard
        usageCard = contentView.usageCard
        
        addButtonTarget()
        setUpContent()
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
    
    private func setUpContent() {
        if let selectedWord = selectedWord {
            wordLabel.text = selectedWord.word
            categoryLabel.text = selectedWord.result?.partOfSpeech ?? ""
            let definition = selectedWord.result?.definition ?? ""
            definitionLabel.text = definition
            
            antonymsCard.insertWords(words: selectedWord.result?.antonyms ?? nil)
            synonymsCard.insertWords(words: selectedWord.result?.synonyms ?? nil)
            usageCard.insertUsages(usages: selectedWord.result?.examples ?? nil)
            
            checkWordFavInCoreData(word: selectedWord.word, definition: definition)
        }
        
        if let passedFavWord = passedFavWord {
            wordLabel.text = passedFavWord.word
            categoryLabel.text = passedFavWord.partOfSpeech ?? ""
            definitionLabel.text = passedFavWord.definition ?? ""
            
            antonymsCard.insertWords(words: passedFavWord.antonyms ?? nil)
            synonymsCard.insertWords(words: passedFavWord.synonyms ?? nil)
            usageCard.insertUsages(usages: passedFavWord.examples ?? nil)
            
            favoriteButton.isSelected = true
            favoriteButton.toggleFavorite()
        }
        
        
    }
    
    private func checkWordFavInCoreData(word: String, definition: String?) {
        DataManager.fetchFavWord(usingWord: word, definition: definition) { word in
            if word != nil {
                DispatchQueue.main.async { [weak self] in
                    self?.favoriteButton.isSelected = true
                    self?.favoriteButton.toggleFavorite()
                }
            }
        }
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
