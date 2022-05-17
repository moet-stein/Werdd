//
//  HomeView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 28.03.22.
//

import UIKit

class HomeView: UIView {
    
//    private let words = Words().words.sorted(by: {$0.word.lowercased() < $1.word.lowercased()})
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "LightGreen")
        return scrollView
    }()
    
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
    

    // MARK: - TableView
    
    let wordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = UIColor(named: "ViewLightYellow")
        tableView.register(WordsTableViewCell.self, forCellReuseIdentifier: WordsTableViewCell.identifier)
        return tableView
    }()
    
    let tableViewSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let noWordFoundInTableView: NoWordFoundView = {
        let view = NoWordFoundView(labelText: "No Word Found")
        view.isHidden = true
        return view
    }()
    
    let topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true

        return view
    }()
    
    let noInternetView: NotFoundWithImageView = {
       let view = NotFoundWithImageView(title: "No Internet Connection", imageName: "NoInternet")
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        createOuterComponents()
        createCardInsideView()
    }
    
    private func createOuterComponents() {
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(viewFavoritesButton)
        scrollView.addSubview(cardView)
        scrollView.addSubview(wordsTableView)
        
        cardView.addSubview(cardSpinner)
        cardView.addSubview(noWordFoundInRandomCard)
        wordsTableView.addSubview(tableViewSpinner)
        wordsTableView.addSubview(noWordFoundInTableView)
        
        scrollView.addSubview(noInternetView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 350),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            viewFavoritesButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            viewFavoritesButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            
            cardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            cardView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 350),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
            cardSpinner.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            cardSpinner.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            noWordFoundInRandomCard.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            noWordFoundInRandomCard.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            noWordFoundInRandomCard.widthAnchor.constraint(equalToConstant: 250),
            noWordFoundInRandomCard.heightAnchor.constraint(equalToConstant: 100),
            
            wordsTableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            wordsTableView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 40),
            wordsTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            wordsTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            wordsTableView.heightAnchor.constraint(equalToConstant: 500),
            wordsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            tableViewSpinner.centerXAnchor.constraint(equalTo: wordsTableView.centerXAnchor),
            tableViewSpinner.centerYAnchor.constraint(equalTo: wordsTableView.centerYAnchor),
            
            noWordFoundInTableView.centerXAnchor.constraint(equalTo: wordsTableView.centerXAnchor),
            noWordFoundInTableView.topAnchor.constraint(equalTo: wordsTableView.topAnchor, constant: 100),
            noWordFoundInTableView.widthAnchor.constraint(equalToConstant: 250),
            noWordFoundInTableView.heightAnchor.constraint(equalToConstant: 100),
            
            noInternetView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            noInternetView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            noInternetView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            noInternetView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
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
