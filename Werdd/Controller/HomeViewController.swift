//
//  ViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 08.03.22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var wordManager = WordManager()
    
    private var words = [SingleResult]()
    
    private var contentView: HomeView!
    
    private var viewFavoritesButton: IconButton!
    
    private var cardSpinner: UIActivityIndicatorView!
    private var tableViewSpinner: UIActivityIndicatorView!
    
    private var wordLabel: UILabel!
    private var categoryImageView: CategoryImage!
    private var definitionLabel: UILabel!
    
    private var randomWordButton: IconButton!
    private var wordsTableView: UITableView!
    
    private let searchBar:UISearchBar = UISearchBar()
    
    private var noWordFoundInTableView: NoWordFoundView!
    private var noWordFoundInRandomCard: NoWordFoundView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.wordsTableView.indexPathForSelectedRow{
            self.wordsTableView.deselectRow(at: index, animated: true)
        }
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func loadView() {
        wordManager.delegate = self
        
        contentView = HomeView()
        view = contentView
        
        viewFavoritesButton = contentView.viewFavoritesButton
        
        cardSpinner = contentView.cardSpinner
        tableViewSpinner = contentView.tableViewSpinner
        
        wordLabel = contentView.wordLabel
        categoryImageView = contentView.categoryImageView
        definitionLabel = contentView.definitionLabel
        categoryImageView.isHidden = true
        
        randomWordButton = contentView.randomWordButton
        
        wordsTableView = contentView.wordsTableView
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        
        wordsTableView.estimatedRowHeight = 100
        wordsTableView.rowHeight = UITableView.automaticDimension
        
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.barTintColor = UIColor(named: "ViewLightYellow")
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(named: "ViewLightYellow")?.cgColor
        searchBar.delegate = self
        
        wordsTableView.tableHeaderView = searchBar
        
        noWordFoundInTableView = contentView.noWordFoundInTableView
        noWordFoundInRandomCard = contentView.noWordFoundInRandomCard
        
        wordManager.fetchRandomWord(spinner: cardSpinner)
        wordManager.fetchInputWord(inputWord: "grateful", spinner: tableViewSpinner)
        addRandomButtonTarget()
        addFavoritesButtonTarget()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func addRandomButtonTarget() {
        randomWordButton.addTarget(self, action: #selector(randomWordButtonTapped), for: .touchUpInside)
    }
    
    private func addFavoritesButtonTarget() {
        viewFavoritesButton.addTarget(self, action: #selector(viewFavoritesButtonTapped), for: .touchUpInside)
    }
    
    private func refreshCard(word: Word) {
        let word = word
        wordLabel.text = word.word
        if let category = word.results?[0].partOfSpeech {
            categoryImageView.isHidden = false
            categoryImageView.image = UIImage(named: category)
        } else {
            categoryImageView.isHidden = true
        }
        
        if let definition =  word.results?[0].definition {
            definitionLabel.text = definition
        } else {
            definitionLabel.text = "No definition found for this word"
        }
        
        wordLabel.zoomIn(duration: 0.5)
        categoryImageView.zoomIn(duration: 0.5)
        definitionLabel.zoomIn(duration: 0.5)
    }

    @objc func randomWordButtonTapped() {
        randomWordButton.isUserInteractionEnabled = false
        wordManager.fetchRandomWord(spinner: cardSpinner)
    }
    
    @objc func viewFavoritesButtonTapped() {
        navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
}



extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordsTableViewCell.identifier, for: indexPath) as? WordsTableViewCell else {
            return UITableViewCell()
        }
        
        let wordForRow = words[indexPath.row]
        cell.setupCellContent(image: wordForRow.result?.partOfSpeech, word: wordForRow.word, definition: wordForRow.result?.definition)
        cell.backgroundColor = UIColor(named: "ViewLightYellow")
        tableView.separatorStyle = .none
        
        return cell
        
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord = words[indexPath.row]
        navigationController?.pushViewController(DetailsViewController(passedFavWord: nil, selectedWord: selectedWord), animated: true)
    }
}


extension HomeViewController: UISearchBarDelegate {
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
        searchBar.endEditing(true)
        wordsTableView.isUserInteractionEnabled = false
        if let searchedWord = searchBar.searchTextField.text  {
            wordManager.fetchInputWord(inputWord: searchedWord.lowercased(), spinner: tableViewSpinner)
        }
        
    }

}

extension HomeViewController: WordManegerDelegate {
    
    func didUpdateWord(_ wordManager: WordManager, word: Word) {
        DispatchQueue.main.async {
            self.wordLabel.isHidden = false
            self.definitionLabel.isHidden = false
            self.categoryImageView.isHidden = false
            if !self.noWordFoundInRandomCard.isHidden {
                self.noWordFoundInRandomCard.isHidden = true
            }

            self.refreshCard(word: word)
            self.cardSpinner.stopAnimating()
            self.randomWordButton.isUserInteractionEnabled = true
        }
    }
    
    func didUpdateTableView(_ wordManager: WordManager, word: Word) {
        words = [SingleResult]()
        DispatchQueue.main.async {
            if let results = word.results {
                for result in results {
                    self.words.append(SingleResult(word: word.word, result: result))
                }
            }  else {
                self.words.append(SingleResult(word: word.word, result: nil))
            }
            if !self.noWordFoundInTableView.isHidden {
                self.noWordFoundInTableView.isHidden = true
            }
            self.wordsTableView.reloadData()
            self.tableViewSpinner.stopAnimating()
            self.wordsTableView.isUserInteractionEnabled = true
        }
    }
    
    func didFailWithError(error: Error?, random: Bool) {
        DispatchQueue.main.async {
            if random {
                self.wordLabel.isHidden = true
                self.definitionLabel.isHidden = true
                self.categoryImageView.isHidden = true
                self.noWordFoundInRandomCard.isHidden = false
                self.cardSpinner.stopAnimating()
                self.randomWordButton.isUserInteractionEnabled = true
            } else {
                self.words = []
                self.wordsTableView.reloadData()
                self.noWordFoundInTableView.isHidden = false
                self.tableViewSpinner.stopAnimating()
                self.wordsTableView.isUserInteractionEnabled = true
            }
            
        }
        if let error = error {
            print(error)
        }
    }
    
}
