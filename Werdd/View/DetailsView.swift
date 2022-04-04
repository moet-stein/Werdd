//
//  DetailsView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class DetailsView: UIView {
    private var selectedWord: String
    
    private let testLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return label
    }()
    
    init(selectedWord: String) {
        self.selectedWord = selectedWord
        super.init(frame: .zero)
        
        backgroundColor = .white
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(testLabel)
        
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            testLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        testLabel.text = selectedWord
    }
}
