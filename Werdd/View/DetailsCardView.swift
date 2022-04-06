//
//  DetailsCardView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 05.04.22.
//

import UIKit

class DetailsCardView: UIView {
    var bgColorName: String
    var cardHeight: CGFloat
    var bottomLabelText: String
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 17)
        return label
    }()

    
    init(bgColorName: String, cardHeight: CGFloat, bottomLabelText: String, frame: CGRect = .zero) {
        self.bgColorName = bgColorName
        self.cardHeight = cardHeight
        self.bottomLabelText = bottomLabelText
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor(named: bgColorName)
        heightAnchor.constraint(equalToConstant: cardHeight).isActive = true
        bottomLabel.text = bottomLabelText
        
        layer.cornerRadius = 20
        widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(bottomLabel)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: cardHeight),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func insertWords(words: String) {
        let label: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = words
            label.textColor = .white
            label.font = UIFont(name: "LeagueSpartan-Regular", size: 18)
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            return label
        }()
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.widthAnchor.constraint(equalToConstant: 270),
        ])
        
    }
    
    func insertUsages(usages:[String]) {
        let verticalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.distribution = .fillProportionally
            return stackView
        }()
        
        addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            verticalStackView.widthAnchor.constraint(equalToConstant: 270),
        ])
        
        for usage in usages {
            let label: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = usage
                label.textColor = .white
                label.font = UIFont(name: "LeagueSpartan-Regular", size: 18)
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 0
                return label
            }()
            verticalStackView.addArrangedSubview(label)
        }
    }
    
}
