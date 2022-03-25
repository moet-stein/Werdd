//
//  ViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 08.03.22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let words = Words().words.sorted(by: {$0.word.lowercased() < $1.word.lowercased()})
    
    var word = ""
    var category = ""
    var definition = ""
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "LightGreen")
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Werdd."
        label.textAlignment = .left
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 40)
        label.textColor = UIColor(named: "DarkGreen")
        return label
    }()
    
    let cardView: UIView = {
        let roundedView = UIView()
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.backgroundColor = UIColor(named: "ViewLightYellow")
        roundedView.layer.cornerRadius = 20
        return roundedView
    }()
    
    let cardInsideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
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
        label.textColor = UIColor(named: "DarkGreen")
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
        label.textColor = UIColor(named: "DarkGreen")
        label.text = "noun"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "craeting a sequence of instructions to enable the computer to do something"
        label.font = UIFont(name: "LeagueSpartan-Light", size: 19)
        label.textColor = UIColor(named: "DarkGreen")
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let buttonWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = UIColor(named: "ViewLightYellow")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        setUpUI()
        
        //        wordsTableView.delegate = self
        wordsTableView.dataSource = self
    }
    
    private func setUpUI() {
        createOuterComponents()
        createCardInsideView()
    }
    
    private func createOuterComponents() {
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(cardView)
        scrollView.addSubview(wordsTableView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            cardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 8),
            cardView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -8),
            cardView.heightAnchor.constraint(equalToConstant: 180),
            
            wordsTableView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 40),
            wordsTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            wordsTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            wordsTableView.heightAnchor.constraint(equalToConstant: 500),
            wordsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func createCardInsideView() {
        createWordHorizontalStackView()
        
        cardView.addSubview(cardInsideStackView)
       
        
        NSLayoutConstraint.activate([
            cardInsideStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            cardInsideStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            cardInsideStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
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


extension HomeViewController : UITableViewDataSource {
    //datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    //datasource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        var content = cell.defaultContentConfiguration()
        content.text = words[indexPath.row].word
        
        if let font = UIFont(name: "LeagueSpartan-Bold", size: 22) {
            content.textProperties.font = font
        }
        
        if let fontColor = UIColor(named: "DarkGreen") {
            content.textProperties.color = fontColor
            content.secondaryTextProperties.color = fontColor
        }
        
        if let secondFont = UIFont(name: "LeagueSpartan-ExtraLight", size: 17) {
            content.secondaryTextProperties.font = secondFont
        }

        content.secondaryText = words[indexPath.row].definition
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor(named: "ViewLightYellow")
        return cell
    }
    
    
}

extension HomeViewController : UITableViewDelegate {

}
