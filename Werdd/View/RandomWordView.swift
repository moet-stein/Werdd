//
//  RandomWordView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 10.05.22.
//

import UIKit

class RandomWordView: UIView {

    private let cardView: UIView = {
        let roundedView = UIView()
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.backgroundColor = UIColor(named: "ViewLightYellow")
        roundedView.layer.cornerRadius = 20
        roundedView.isUserInteractionEnabled = true
        return roundedView
    }()
    
    let cardSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
//        spinner.isHidden = true
        return spinner
    }()
    
    // MARK: - Components Inside the card
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 30)
        label.textColor = UIColor(named: "DarkGreen")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    
    let categoryImageView: CategoryImage = {
        let imageView = CategoryImage(size: 36)
        imageView.addBorder()
        imageView.isHidden = true
        return imageView
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Light", size: 19)
        label.textColor = UIColor(named: "DarkGreen")
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 4
        label.textAlignment = .left
        return label
    }()
    
    
     let randomWordButton: IconButton = {
        let button = IconButton(
            size: 35,
            systemName: "arrow.clockwise.circle",
            iconColor: UIColor(red: 0.40, green: 0.50, blue: 0.42, alpha: 1.00)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
         button.isUserInteractionEnabled = true
        button.rotateButton()
        return button
    }()
    
    let seeDetailsButton: IconButton = {
        let button = IconButton(
            size: 35,
            systemName: "eyes",
            iconColor: UIColor(red: 0.40, green: 0.50, blue: 0.42, alpha: 1.00)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.zoomInButton()
        return button
    }()
    
    let noWordFoundInRandomCard: NoWordFoundView = {
        let view = NoWordFoundView(labelText: "No Random Word Generated")
        view.isHidden = true
        return view
    }()
    
    
    init() {
        super.init(frame: .zero)
//        setUpUI()
//        createCardInsideView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setUpUI()
        createCardInsideView()
    }

    private func setUpUI() {
        addSubview(cardView)
        
        cardView.addSubview(cardSpinner)
        cardView.addSubview(noWordFoundInRandomCard)
        
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 350),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
            cardSpinner.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            cardSpinner.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            noWordFoundInRandomCard.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            noWordFoundInRandomCard.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            noWordFoundInRandomCard.widthAnchor.constraint(equalToConstant: 250),
            noWordFoundInRandomCard.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func createCardInsideView() {
        cardView.addSubview(wordLabel)
        cardView.addSubview(categoryImageView)
        cardView.addSubview(definitionLabel)
        cardView.addSubview(randomWordButton)
        cardView.addSubview(seeDetailsButton)
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            wordLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            wordLabel.widthAnchor.constraint(equalToConstant: 250),
            
            categoryImageView.centerYAnchor.constraint(equalTo: wordLabel.centerYAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo: wordLabel.trailingAnchor, constant: 20),
            
            definitionLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 20),
            definitionLabel.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            
            seeDetailsButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            seeDetailsButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
            
            randomWordButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            randomWordButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
        ])
    }
}
