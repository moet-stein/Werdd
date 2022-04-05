//
//  DetailsCardView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 05.04.22.
//

import UIKit

class DetailsCardView: UIView {
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 17)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    convenience init(bgColorName: String, cardHeight: CGFloat, bottomLabelText: String) {
        self.init(frame: .zero)
        backgroundColor = UIColor(named: bgColorName)
        heightAnchor.constraint(equalToConstant: cardHeight).isActive = true
        bottomLabel.text = bottomLabelText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(bottomLabel)
        NSLayoutConstraint.activate([
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func insertWords(words: [String]) {
        
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
