//
//  WordsTableViewCell.swift
//  Werdd
//
//  Created by Moe Steinmueller on 30.03.22.
//

import UIKit

class WordsTableViewCell: UITableViewCell {
    static let identifier = "WordsTableViewCell"
    
    private let roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "CellBgGreen")
        return view
    }()
    
    private let categoryImage: CategoryImage = {
        let imageView = CategoryImage(size: 36)
        return imageView
    }()
    
    private let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 20)
        label.textColor = UIColor(named: "DarkGreen")
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Light", size: 18)
        label.textColor = UIColor(named: "DarkGreen")
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    private func setUpUI() {
        contentView.addSubview(roundedView)
        roundedView.addSubview(wordLabel)
        roundedView.addSubview(definitionLabel)
        roundedView.addSubview(categoryImage)
        
        NSLayoutConstraint.activate([
            roundedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            roundedView.widthAnchor.constraint(equalToConstant: 350),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            wordLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 15),
            wordLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 20),
            wordLabel.widthAnchor.constraint(equalToConstant: 200),
            
            definitionLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 3),
            definitionLabel.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor),
            definitionLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -5),
            definitionLabel.widthAnchor.constraint(equalToConstant: 250),
            
            categoryImage.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -20),
        ])
    }
    
    
    func setupCellContent(image: String, word: String, definition: String) {
        categoryImage.image = UIImage(named: image)
        wordLabel.text = word
        definitionLabel.text = definition
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
