//
//  ViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 08.03.22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let words = Words().words.sorted(by: {$0.word.lowercased() < $1.word.lowercased()})
    
    private var contentView: HomeView!
    private var wordsTableView: UITableView!
    
    override func loadView() {
        contentView = HomeView()
        view = contentView
        
        wordsTableView = contentView.wordsTableView
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        wordsTableView.register(WordsTableViewCell.self, forCellReuseIdentifier: WordsTableViewCell.identifier)
        
        wordsTableView.estimatedRowHeight = 100
        wordsTableView.rowHeight = UITableView.automaticDimension
    }
}



extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordsTableViewCell.identifier, for: indexPath) as? WordsTableViewCell else {
        //            return UITableViewCell()
        //        }
        tableView.separatorStyle = .none
        if let cell = tableView.dequeueReusableCell(withIdentifier: WordsTableViewCell.identifier, for: indexPath) as? WordsTableViewCell {
            let wordForRow = words[indexPath.row]
            cell.setupCellContent(image: wordForRow.category, word: wordForRow.word, definition: wordForRow.definition)
            cell.backgroundColor = UIColor(named: "ViewLightYellow")
            return cell
        }
        fatalError("could not dequeueReusableCell")
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(words[indexPath.row].word)")
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
