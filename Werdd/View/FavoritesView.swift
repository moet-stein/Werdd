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
    
    let favsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = UIColor(named: "ViewLightYellow")
        tableView.register(WordsTableViewCell.self, forCellReuseIdentifier: WordsTableViewCell.identifier)
        return tableView
    }()
    
    let favSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let noFavFoundView: NoWordFoundView = {
        let view = NoWordFoundView(labelText: "No FavWords Found")
        view.isHidden = true
        return view
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
        addSubview(favsTableView)
        
        NSLayoutConstraint.activate([
            favsTableView.topAnchor.constraint(equalTo: topAnchor),
            favsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
