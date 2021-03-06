//
//  HomeView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 28.03.22.
//

import UIKit

class HomeView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Werdd."
        label.textAlignment = .left
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 40)
        label.textColor = UIColor(named: "DarkGreen")
        return label
    }()
    
    let viewFavoritesButton: IconButton = {
       let button = IconButton(
        size: 40,
        systemName: "heart.text.square.fill",
        iconColor: UIColor(red: 0.86, green: 0.42, blue: 0.59, alpha: 1.00))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cardView: UIView = {
        let roundedView = UIView()
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.backgroundColor = UIColor(named: "ViewLightYellow")
        roundedView.layer.cornerRadius = 20
        return roundedView
    }()
    
    let cardSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Components Inside the car
    
    private let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 30)
        label.textColor = UIColor(named: "DarkGreen")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    
    private let categoryImageView: CategoryImage = {
        let imageView = CategoryImage(size: 36)
        imageView.addBorder()
        imageView.isHidden = true
        return imageView
    }()
    
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Light", size: 19)
        label.textColor = UIColor(named: "DarkGreen")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
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
    
    private let noWordFoundInRandomCard: NoWordFoundView = {
        let view = NoWordFoundView(labelText: "No Random Word Generated")
        view.isHidden = true
        return view
    }()
    

    // MARK: - TableView
    
    let wordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = UIColor(named: "ViewLightYellow")
        tableView.register(WordsTableViewCell.self, forCellReuseIdentifier: WordsTableViewCell.identifier)
        return tableView
    }()
    
    let tableViewSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        return spinner
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.barTintColor = UIColor(named: "ViewLightYellow")
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(named: "ViewLightYellow")?.cgColor
        return searchBar
    }()
    
    private let noWordFoundInTableView: NoWordFoundView = {
        let view = NoWordFoundView(labelText: "No Word Found")
        view.isHidden = true
        return view
    }()

    private let noInternetView: NotFoundWithImageView = {
       let view = NotFoundWithImageView(title: "No Internet Connection", imageName: "NoInternet")
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setUpUI()
        backgroundColor = UIColor(named: "LightGreen")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        createOuterComponents()
        createCardInsideView()
    }
    
    private func createOuterComponents() {
        addSubview(titleLabel)
        addSubview(viewFavoritesButton)
        addSubview(cardView)
        addSubview(wordsTableView)
        
        cardView.addSubview(cardSpinner)
        cardView.addSubview(noWordFoundInRandomCard)
        wordsTableView.addSubview(noWordFoundInTableView)
        
        addSubview(noInternetView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 350),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            viewFavoritesButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            viewFavoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            cardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            cardSpinner.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            cardSpinner.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            noWordFoundInRandomCard.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            noWordFoundInRandomCard.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            noWordFoundInRandomCard.widthAnchor.constraint(equalToConstant: 250),
            noWordFoundInRandomCard.heightAnchor.constraint(equalToConstant: 100),
            
            wordsTableView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 40),
            wordsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wordsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            wordsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            noWordFoundInTableView.centerXAnchor.constraint(equalTo: wordsTableView.centerXAnchor),
            noWordFoundInTableView.topAnchor.constraint(equalTo: wordsTableView.topAnchor, constant: 100),
            noWordFoundInTableView.widthAnchor.constraint(equalToConstant: 250),
            noWordFoundInTableView.heightAnchor.constraint(equalToConstant: 100),
            
            noInternetView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            noInternetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            noInternetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            noInternetView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
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
            wordLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -60),
            
            categoryImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 5),
            categoryImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            
            definitionLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 20),
            definitionLabel.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            definitionLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -60),
            
            seeDetailsButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            seeDetailsButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
            
            randomWordButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            randomWordButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
        ])
    }
    
    func refreshCard(word: WordViewModel) {
        wordLabel.text = word.word
        
        categoryImageView.image = word.partOfSpeech
        categoryImageView.isHidden = word.hidePOS
        definitionLabel.text = word.definition
        
        wordLabel.zoomIn(duration: 0.5)
        categoryImageView.zoomIn(duration: 0.5)
        definitionLabel.zoomIn(duration: 0.5)
        
        self.cardSpinner.stopAnimating()
        self.randomWordButton.isUserInteractionEnabled = true
    }
    
    func showRandomWordNotFound() {
        wordLabel.isHidden = true
        definitionLabel.isHidden = true
        categoryImageView.isHidden = true
        noWordFoundInRandomCard.isHidden = false
        cardSpinner.stopAnimating()
        randomWordButton.isUserInteractionEnabled = true
    }
    
    func toggleNoInternetView(internet: Bool) {
        noInternetView.isHidden = internet
    }
    
    func toggleNoWordFoundInTableView(wordExisted: Bool) {
        noWordFoundInTableView.isHidden = wordExisted
    }
}
