//
//  DetailsView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class DetailsView: UIView {
    private var selectedWord: SingleResult
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "ViewLightYellow")
        return scrollView
    }()
    
    private let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 40)
        label.textColor = UIColor(named: "DarkGreen")
        return label
    }()
    
    private let outerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 30
        return view
    }()
    
    private let definitionCard: DetailsCardView = {
        let view = DetailsCardView(
            bgColorName: "LightGreen",
            cardHeight: 150,
            bottomLabelText: "Definition")
        return view
    }()
    
    private let synonymsCard: DetailsCardView = {
        let view = DetailsCardView(
            bgColorName: "DarkGreen",
            cardHeight: 100,
            bottomLabelText: "Synonyms")
//        view.insertWords(words: "glad, cheerful")
        return view
    }()
    
    private let antonymsCard: DetailsCardView = {
        let view = DetailsCardView(
            bgColorName: "SoftBrown",
            cardHeight: 100,
            bottomLabelText: "Antonyms")
        
//        view.insertWords(words: "unhappy, sad")
        return view
    }()
    
    private let usageCard: DetailsCardView = {
        let view = DetailsCardView(
            bgColorName: "MatchaGreen",
            cardHeight: 180,
            bottomLabelText: "Example Usage")
        
//        view.insertUsages(usages: ["a happy smile", "spent many happy days on the beach", "a happy marriage"])
        return view
    }()
    
    // MARK: - DefinitionCard inside
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 20)
        label.textColor = UIColor(named: "DarkGreen")
        return label
    }()
    
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Regular", size: 18)
        label.textColor = UIColor(named: "DarkGreen")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    
    
    init(selectedWord: SingleResult) {
        self.selectedWord = selectedWord
        super.init(frame: .zero)
        
        setScrollView()
        setUpUI()
        setUpDefinitionCard()
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setScrollView() {
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpUI() {
        wordLabel.text = selectedWord.word
        scrollView.addSubview(wordLabel)
        scrollView.addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            wordLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            wordLabel.widthAnchor.constraint(equalToConstant: 200),
            
            outerStackView.topAnchor.constraint(equalTo: wordLabel.bottomAnchor),
            outerStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        outerStackView.addArrangedSubview(definitionCard)
        outerStackView.addArrangedSubview(synonymsCard)
        outerStackView.addArrangedSubview(antonymsCard)
        outerStackView.addArrangedSubview(usageCard)
    }
    
    private func setUpDefinitionCard() {
        definitionCard.addSubview(categoryLabel)
        definitionCard.addSubview(definitionLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: definitionCard.topAnchor, constant: 15),
            categoryLabel.leadingAnchor.constraint(equalTo: definitionCard.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(equalToConstant: 100),
            
            definitionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            definitionLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            definitionLabel.widthAnchor.constraint(equalToConstant: 270),
            
        ])
    }
    
    private func setUpContent() {
        categoryLabel.text = selectedWord.result?.partOfSpeech ?? ""
        definitionLabel.text = selectedWord.result?.definition ?? ""
        
        antonymsCard.insertWords(words: selectedWord.result?.antonyms ?? nil)
        synonymsCard.insertWords(words: selectedWord.result?.synonyms ?? nil)
        usageCard.insertUsages(usages: selectedWord.result?.examples ?? nil)
        
    }
}
