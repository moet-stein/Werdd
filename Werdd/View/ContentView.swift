//
//  ContentView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 16.03.22.
//

import UIKit

class ContentView: UIView {
    
    let words = Words().words
    
    var word = ""
    var category = ""
    var definition = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        setUpUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(red: 0.83, green: 0.89, blue: 0.80, alpha: 1.00)
        return scrollView
    }()
    
//    let outerVerticalStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .fillProportionally
//        return stackView
//    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Werdd."
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: 300).isActive = true
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 40)
        label.textColor = UIColor(red: 0.40, green: 0.50, blue: 0.42, alpha: 1.00)
        //        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return label
    }()
    
    let cardView: UIView = {
        let roundedView = UIView()
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.backgroundColor = UIColor(red: 0.96, green: 0.93, blue: 0.86, alpha: 1.00)
//        roundedView.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        roundedView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        roundedView.layer.cornerRadius = 20
        return roundedView
    }()
    
    let cardInsideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        //        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: - Components Inside the card
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return stackView
    }()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 30)
        label.textColor = UIColor(red: 0.40, green: 0.50, blue: 0.42, alpha: 1.00)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 180
        label.text = "Programming"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-ExtraLight", size: 20)
        label.textColor = UIColor(red: 0.40, green: 0.50, blue: 0.42, alpha: 1.00)
        label.text = "noun"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "craeting a sequence of instructions to enable the computer to do something"
        label.font = UIFont(name: "LeagueSpartan-Light", size: 17)
        label.textColor = UIColor(red: 0.40, green: 0.50, blue: 0.42, alpha: 1.00)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let buttonWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.backgroundColor = .systemCyan
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.widthAnchor.constraint(equalToConstant: 280).isActive = true
        return view
    }()
    
    
    lazy var randomWordButton: IconButton = {
        let button = IconButton(size: 25, systemName: "arrow.clockwise.circle", tintColor: UIColor(red: 0.40, green: 0.50, blue: 0.42, alpha: 1.00))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(refreshCard), for: .touchUpInside)
        return button
    }()
    
    // MARK: - TableView
    
    let wordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    @objc func refreshCard() {
        let randomInt = Int.random(in: 0..<words.count)
        word = words[randomInt].word
        wordLabel.text = word
        category = words[randomInt].category
        categoryLabel.text = category
        definition = words[randomInt].definition
        definitionLabel.text = definition
    }
    
    private func setUpUI() {
        createOuterComponents()
        createCardInsideView()
    }
    
    private func createOuterComponents() {
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 45),
            
            cardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 180)
        ])

    }
    
    private func createCardInsideView() {
        createWordHorizontalStackView()
        
        cardView.addSubview(cardInsideStackView)
       
        
        NSLayoutConstraint.activate([
            cardInsideStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            cardInsideStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            cardInsideStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            cardInsideStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
        ])
        
        cardInsideStackView.addArrangedSubview(horizontalStackView)
        cardInsideStackView.addArrangedSubview(definitionLabel)
        cardInsideStackView.addArrangedSubview(buttonWrapper)

        buttonWrapper.addSubview(randomWordButton)
        NSLayoutConstraint.activate([
            randomWordButton.topAnchor.constraint(equalTo: buttonWrapper.topAnchor),
            randomWordButton.trailingAnchor.constraint(equalTo: buttonWrapper.trailingAnchor),
        ])
        
    }
    
    private func createWordHorizontalStackView() {
        horizontalStackView.addArrangedSubview(wordLabel)
        horizontalStackView.addArrangedSubview(categoryLabel)
    }
    
}
