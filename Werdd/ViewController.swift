//
//  ViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 08.03.22.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(red: 0.83, green: 0.89, blue: 0.80, alpha: 1.00)
        return scrollView
    }()
    
    let outerVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
//        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
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
        roundedView.layer.shadowColor = UIColor.gray.cgColor
        roundedView.layer.shadowOpacity = 0.6
        roundedView.layer.shadowOffset = .zero
        roundedView.layer.shadowRadius = 20
        roundedView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        roundedView.heightAnchor.constraint(equalToConstant: 180).isActive = true
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setUpUI()
        
    }
    
    
    func setUpUI() {
        createOutsideStackView()
        createCardInsideView()
    }
    
    func createOutsideStackView() {
        scrollView.addSubview(outerVerticalStackView)
        
        NSLayoutConstraint.activate([
            outerVerticalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60),
            outerVerticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            outerVerticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            outerVerticalStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.3),
            outerVerticalStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            outerVerticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 40)
        ])
        
        outerVerticalStackView.addArrangedSubview(titleLabel)
        outerVerticalStackView.addArrangedSubview(cardView)
    }
    
    func createCardInsideView() {
        createWordHorizontalStackView()
        
        cardView.addSubview(cardInsideStackView)
        
        NSLayoutConstraint.activate([
            cardInsideStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            cardInsideStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            cardInsideStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            cardInsideStackView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.5),
//            cardInsideStackView.widthAnchor.constraint(equalTo: cardView.widthAnchor),
        ])
        
        cardInsideStackView.addArrangedSubview(horizontalStackView)
        cardInsideStackView.addArrangedSubview(definitionLabel)
    }
    
    func createWordHorizontalStackView() {
        horizontalStackView.addArrangedSubview(wordLabel)
        horizontalStackView.addArrangedSubview(categoryLabel)
    }
}


