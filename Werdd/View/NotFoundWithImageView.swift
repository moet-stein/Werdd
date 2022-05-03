//
//  NoInternetView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 03.05.22.
//

import UIKit

class NotFoundWithImageView: UIView {
    private var title: String
    private var imageName: String
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 30)
        label.textColor = UIColor(named: "DarkGreen")
        label.textAlignment = .center
        return label
    }()
    
    private let noInternetImageView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return uiImageView
    }()

    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
        super.init(frame: .zero)
        
        setUpUI()
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        backgroundColor = UIColor(named: "CellBgGreen")
        
        addSubview(titleLabel)
        addSubview(noInternetImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            noInternetImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            noInternetImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noInternetImageView.widthAnchor.constraint(equalToConstant: 250),
            noInternetImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setUpContent() {
        titleLabel.text = title
        
        let image = UIImage(named: imageName)
        noInternetImageView.contentMode = UIView.ContentMode.scaleAspectFill
        noInternetImageView.image = image
    }
}
