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
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
}
