//
//  WordsTableViewCell.swift
//  Werdd
//
//  Created by Moe Steinmueller on 30.03.22.
//

import UIKit

class WordsTableViewCell: UITableViewCell {
    static let identifier = "WordsTableViewCell"
    
    let roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "CellBgGreen")
        return view
    }()
    
    let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.layer.cornerRadius = 30 / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 18)
        label.textColor = UIColor(named: "DarkGreen")
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Light", size: 15)
        label.textColor = UIColor(named: "DarkGreen")
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    private func setUpUI() {
        addSubview(roundedView)
        NSLayoutConstraint.activate([
            roundedView.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundedView.centerYAnchor.constraint(equalTo: centerYAnchor),
            roundedView.widthAnchor.constraint(equalToConstant: 350),
            roundedView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        roundedView.addSubview(wordLabel)
        roundedView.addSubview(definitionLabel)
        roundedView.addSubview(categoryImage)
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 15),
            wordLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 20),
            wordLabel.widthAnchor.constraint(equalToConstant: 200),
            
            definitionLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 3),
            definitionLabel.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor),
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
