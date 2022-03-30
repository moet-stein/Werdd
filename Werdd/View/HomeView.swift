//
//  HomeView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 28.03.22.
//

import UIKit

class HomeView: UIView {
    let words = Words().words.sorted(by: {$0.word.lowercased() < $1.word.lowercased()})
    
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
    
    // MARK: - Components Inside the car
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
    
    
    lazy var randomWordButton: IconButton = {
        let button = IconButton(
            size: 35,
            systemName: "arrow.clockwise.circle",
            iconColor: UIColor(red: 0.40, green: 0.50, blue: 0.42, alpha: 1.00),
            completion: refreshCard)
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    func refreshCard() {
        let randomWord = words.randomElement()
        wordLabel.text = randomWord?.word
        categoryLabel.text = randomWord?.category
        horizontalStackView.zoomIn(duration: 0.5)
        
        definitionLabel.text = randomWord?.definition
        definitionLabel.zoomIn(duration: 0.5)
    }
    
    init() {
        //        self.presentable = presentable
        
        super.init(frame: .zero)
        setUpUI()
        
        wordsTableView.dataSource = self
        wordsTableView.delegate = self
        wordsTableView.register(WordsTableViewCell.self, forCellReuseIdentifier: WordsTableViewCell.identifier)
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
        scrollView.addSubview(cardView)
        scrollView.addSubview(wordsTableView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            titleLabel.widthAnchor.constraint(equalToConstant: 350),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            cardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            cardView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 350),
            cardView.heightAnchor.constraint(equalToConstant: 180),
            
            
            wordsTableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            wordsTableView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 40),
            wordsTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            wordsTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            wordsTableView.heightAnchor.constraint(equalToConstant: 500),
            wordsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func createCardInsideView() {
        horizontalStackView.addArrangedSubview(wordLabel)
        horizontalStackView.addArrangedSubview(categoryLabel)
        
        cardView.addSubview(horizontalStackView)
        cardView.addSubview(definitionLabel)
        cardView.addSubview(randomWordButton)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            horizontalStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            horizontalStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            definitionLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 10),
            definitionLabel.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            randomWordButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            randomWordButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
        ])
    }
    
}



extension HomeView : UITableViewDataSource {
    //datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    //datasource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordsTableViewCell.identifier, for: indexPath) as? WordsTableViewCell else {
        //            return UITableViewCell()
        //        }
        tableView.separatorStyle = .none
        if let cell = tableView.dequeueReusableCell(withIdentifier: WordsTableViewCell.identifier, for: indexPath) as? WordsTableViewCell {
//            cell.textLabel?.text = words[indexPath.row].word
            let wordForRow = words[indexPath.row]
            cell.setupCellContent(image: wordForRow.category, word: wordForRow.word, definition: wordForRow.definition)
            cell.backgroundColor = UIColor(named: "ViewLightYellow")
            return cell
        }
        fatalError("could not dequeueReusableCell")
    }
}

extension HomeView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(words[indexPath.row].word)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
