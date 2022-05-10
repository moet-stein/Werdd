//
//  HomeView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 28.03.22.
//

import UIKit

class HomeView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "LightGreen")
        
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Werdd."
        label.textAlignment = .left
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 40)
        label.textColor = UIColor(named: "DarkGreen")
        return label
    }()
    
    let viewFavoritesButton: IconButton = {
       let button = IconButton(
        size: 40,
        systemName: "heart.text.square.fill",
        iconColor: UIColor(red: 0.86, green: 0.42, blue: 0.59, alpha: 1.00))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let noInternetView: NotFoundWithImageView = {
       let view = NotFoundWithImageView(title: "No Internet Connection", imageName: "NoInternet")
        return view
    }()
    
    private let containerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .darkGray
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    
    let bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
//
//    init() {
//        super.init(frame: .zero)
////        scrollView.contentSize = frame.size
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func layoutSubviews() {
        setUpUI()
    }

    private func setUpUI() {
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(viewFavoritesButton)
        scrollView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(topContainerView)
        containerStackView.addArrangedSubview(bottomContainerView)
        
        scrollView.addSubview(noInternetView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 350),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            viewFavoritesButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            viewFavoritesButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            
            containerStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            containerStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            topContainerView.heightAnchor.constraint(equalToConstant: 200),
            bottomContainerView.heightAnchor.constraint(equalToConstant: 420),
          
            noInternetView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            noInternetView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            noInternetView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            noInternetView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
          
        ])
    }
    
}
