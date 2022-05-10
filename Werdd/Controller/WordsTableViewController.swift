//
//  WordsTableViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 10.05.22.
//

import UIKit

class WordsTableViewController: UIViewController {
    var wordManager = WordManager()
    private var words = [SingleResult]()
    
    private var contentView: WordsTableView!
    private var tableViewSpinner: UIActivityIndicatorView!

    private var wordsTableView: UITableView!
    
    private var searchBar:UISearchBar!
    
    private var noWordFoundInTableView: NoWordFoundView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.wordsTableView.indexPathForSelectedRow{
            self.wordsTableView.deselectRow(at: index, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        wordManager.delegate = self
        wordManager.fetchInputWord(inputWord: "grateful")
        
        tableViewSpinner = contentView.tableViewSpinner
        tableViewSpinner.startAnimating()
        
        wordsTableView = contentView.wordsTableView
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        
        searchBar = contentView.searchBar
        searchBar.delegate = self
        wordsTableView.tableHeaderView = searchBar
        
        noWordFoundInTableView = contentView.noWordFoundInTableView
        
    }


}

extension WordsTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
//        return viewModel?.numberOfRowsInSection ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordsTableViewCell.identifier, for: indexPath) as? WordsTableViewCell else {
            return UITableViewCell()
        }

        let wordForRow = words[indexPath.row]
        
        cell.viewModel = WordCellViewModel(wordDetail: wordForRow)
        
        return cell
        
    }
}

extension WordsTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord = words[indexPath.row]
        navigationController?.pushViewController(DetailsViewController(passedFavWord: nil, selectedWord: selectedWord), animated: true)
    }
}


extension WordsTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableViewSpinner.startAnimating()
        searchBar.endEditing(true)
        wordsTableView.isUserInteractionEnabled = false
        if let searchedWord = searchBar.searchTextField.text  {
            wordManager.fetchInputWord(inputWord: searchedWord.lowercased())
        }
        
    }

}

extension WordsTableViewController: WordManegerDelegate {
    
    func didUpdateWord(_ wordManager: WordManager, word: Word) {
//        DispatchQueue.main.async {
//            self.wordLabel.isHidden = false
//            self.definitionLabel.isHidden = false
//            self.categoryImageView.isHidden = false
//            self.noWordFoundInRandomCard.isHidden = true
//
//            self.refreshCard(word: word)
//            self.cardSpinner.stopAnimating()
//            self.randomWordButton.isUserInteractionEnabled = true
//        }
    }
    
    func didUpdateTableView(_ wordManager: WordManager, word: Word) {
       words = [SingleResult]()
        if let results = word.results {
            for result in results {
                self.words.append(SingleResult(word: word.word, result: result))
            }
        }  else {
            self.words.append(SingleResult(word: word.word, result: nil))
        }
        DispatchQueue.main.async {
//            self.viewModel?.wordToSingleResults(from: word)
            self.noWordFoundInTableView.isHidden = true
            self.wordsTableView.reloadData()
            self.tableViewSpinner.stopAnimating()
            self.wordsTableView.isUserInteractionEnabled = true
        }
    }
    
    func didFailWithError(error: Error?, random: Bool) {
        DispatchQueue.main.async {
//            if random {
//                self.wordLabel.isHidden = true
//                self.definitionLabel.isHidden = true
//                self.categoryImageView.isHidden = true
//                self.noWordFoundInRandomCard.isHidden = false
//                self.cardSpinner.stopAnimating()
//                self.randomWordButton.isUserInteractionEnabled = true
//            } else {
                self.words = []
                self.wordsTableView.reloadData()
                self.noWordFoundInTableView.isHidden = false
                self.tableViewSpinner.stopAnimating()
                self.wordsTableView.isUserInteractionEnabled = true
//            }
            
        }
        if let error = error {
            print(error)
        }
    }
    
}
