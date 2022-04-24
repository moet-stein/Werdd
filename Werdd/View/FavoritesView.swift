//
//  FavoritesView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 24.04.22.
//

import UIKit

class FavoritesView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "FAVORITES VIEW"
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 40)
        label.textColor = UIColor(named: "DarkGreen")
        return label
    }()
    
    init() {
//        self.selectedWord = selectedWord
        super.init(frame: .zero)
        backgroundColor = .white
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
