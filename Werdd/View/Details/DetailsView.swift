//
//  DetailsView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class DetailsView: UIView {
    private var selectedWord: WordViewModel?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "ViewLightYellow")
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "ViewLightYellow")
        return view
    }()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 40)
        label.textColor = UIColor(named: "DarkGreen")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let favoriteButton: IconButton = {
       let button = IconButton(size: 40, systemName: "heart", iconColor: UIColor(red: 0.86, green: 0.42, blue: 0.59, alpha: 1.00))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let outerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 30
        view.distribution = .fillProportionally
        return view
    }()
    
    let definitionCard: DetailsCardView = {
        let view = DetailsCardView(
            bgColorName: "LightGreen",
            bottomLabelText: "Definition")
        view.sizeToFit()
        view.layoutIfNeeded()
        return view
    }()
    
    let synonymsCard: DetailsCardView = {
        let view = DetailsCardView(
            bgColorName: "DarkGreen",
            bottomLabelText: "Synonyms")
        return view
    }()
    
    let antonymsCard: DetailsCardView = {
        let view = DetailsCardView(
            bgColorName: "SoftBrown",
            bottomLabelText: "Antonyms")
        return view
    }()
    
    let usageCard: DetailsCardView = {
        let view = DetailsCardView(
            bgColorName: "MatchaGreen",
            bottomLabelText: "Example Usage")
        return view
    }()
    
    // MARK: - DefinitionCard inside
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 20)
        label.textColor = UIColor(named: "DarkGreen")
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Regular", size: 18)
        label.textColor = UIColor(named: "DarkGreen")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    
    
    init(selectedWord: WordViewModel?) {
        self.selectedWord = selectedWord
        super.init(frame: .zero)
        
        setUpUI()
        setUpDefinitionCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(wordLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(outerStackView)
        
        outerStackView.addArrangedSubview(definitionCard)
        outerStackView.addArrangedSubview(synonymsCard)
        outerStackView.addArrangedSubview(antonymsCard)
        outerStackView.addArrangedSubview(usageCard)
        
        let scrollFrameGuide = scrollView.frameLayoutGuide
        let scrollContentGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            wordLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor),
            wordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            wordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            wordLabel.bottomAnchor.constraint(equalTo: outerStackView.topAnchor, constant: -10),

            outerStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    private func setUpDefinitionCard() {
        definitionCard.addSubview(categoryLabel)
        definitionCard.addSubview(definitionLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: definitionCard.topAnchor, constant: 15),
            categoryLabel.leadingAnchor.constraint(equalTo: definitionCard.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(equalToConstant: 100),
            
            definitionLabel.topAnchor.constraint(equalTo: definitionCard.topAnchor, constant: 50),
            definitionLabel.leadingAnchor.constraint(equalTo: definitionCard.leadingAnchor, constant: 10),
            definitionLabel.trailingAnchor.constraint(equalTo: definitionCard.trailingAnchor, constant: -10),
            definitionLabel.bottomAnchor.constraint(equalTo: definitionCard.bottomAnchor, constant: -50)
            
        ])
    }
}
