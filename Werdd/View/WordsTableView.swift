//
//  WordsTableView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 10.05.22.
//

import UIKit

class WordsTableView: UIView {

    let wordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = UIColor(named: "ViewLightYellow")
        tableView.register(WordsTableViewCell.self, forCellReuseIdentifier: WordsTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    let tableViewSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let noWordFoundInTableView: NoWordFoundView = {
        let view = NoWordFoundView(labelText: "No Word Found")
        view.isHidden = true
        return view
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.barTintColor = UIColor(named: "ViewLightYellow")
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(named: "ViewLightYellow")?.cgColor
        return searchBar
    }()
    
    init() {
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(wordsTableView)
        wordsTableView.addSubview(tableViewSpinner)
        wordsTableView.addSubview(noWordFoundInTableView)
        
        NSLayoutConstraint.activate([
            wordsTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            wordsTableView.centerYAnchor.constraint(equalTo: centerYAnchor),
            wordsTableView.heightAnchor.constraint(equalToConstant: 500),
            
            tableViewSpinner.centerXAnchor.constraint(equalTo: wordsTableView.centerXAnchor),
            tableViewSpinner.centerYAnchor.constraint(equalTo: wordsTableView.centerYAnchor),
            
            noWordFoundInTableView.centerXAnchor.constraint(equalTo: wordsTableView.centerXAnchor),
            noWordFoundInTableView.topAnchor.constraint(equalTo: wordsTableView.topAnchor, constant: 100),
            noWordFoundInTableView.widthAnchor.constraint(equalToConstant: 250),
            noWordFoundInTableView.heightAnchor.constraint(equalToConstant: 100),
            
        ])
    }

}
