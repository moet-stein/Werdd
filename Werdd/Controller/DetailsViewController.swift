//
//  DetailsViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class DetailsViewController: UIViewController {
    private var contentView: DetailsView!
    private var selectedWord: SearchedWordViewModel?
    
    private var favoriteButton: IconButton!
    
    private var wordLabel: UILabel!
    private var definitionLabel: UILabel!
    private var categoryLabel: UILabel!
    private var synonymsCard: DetailsCardView!
    private var antonymsCard: DetailsCardView!
    private var usageCard: DetailsCardView!
    
    private var favWordID = UUID()
    
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
    
    init(selectedWord: SearchedWordViewModel?) {
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
            
            if let antonyms = selectedWord.result?.antonyms {
                antonymsCard.insertWords(words: antonyms)
            } else {
                antonymsCard.isHidden = true
            }
            
            if let synonyms = selectedWord.result?.synonyms {
                synonymsCard.insertWords(words: synonyms)
            } else {
                synonymsCard.isHidden = true
            }
            
            if let examples = selectedWord.result?.examples {
                usageCard.insertUsages(usages: examples)
            } else {
                usageCard.isHidden = true
            }
            checkWordFavInCoreData(word: selectedWord.word, definition: definition)
        }
        
        if let wordText = wordLabel.text {
            if wordText.count > 14 {
                wordLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
            } else {
                wordLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            }
        }

        
        
    }
    
    private func checkWordFavInCoreData(word: String, definition: String?) {
        if let definition = definition {
            DataManager.fetchFavWord(usingDefinition: definition) { word in
                if word != nil {
                    DispatchQueue.main.async { [weak self] in
                        self?.favoriteButton.isSelected = true
                        self?.favoriteButton.toggleFavorite()
                    }
                }
            }
        } else {
            DataManager.fetchFavWord(usingWord: word) { word in
                if word != nil {
                    DispatchQueue.main.async { [weak self] in
                        self?.favoriteButton.isSelected = true
                        self?.favoriteButton.toggleFavorite()
                    }
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
            } else {
                DataManager.deleteFavWord(usingID: favWordID)
            }
        }
        
    }
}
