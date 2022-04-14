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
    
    private var wordLabel: UILabel!
    private var categoryImageView: CategoryImage!
    private var definitionLabel: UILabel!
    
    private var randomWordButton: IconButton!
    private var wordsTableView: UITableView!
    
    private let searchBar:UISearchBar = UISearchBar()

    
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
        
        wordManager.fetchRandomWord()
        wordManager.fetchInputWord(inputWord: "grateful")
        addRandomButtonTarget()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func addRandomButtonTarget() {
        randomWordButton.addTarget(self, action: #selector(randomWordButtonTapped), for: .touchUpInside)
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
        wordManager.fetchRandomWord()
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
        print("\(words[indexPath.row].word)")
        let selectedWord = words[indexPath.row]
        navigationController?.pushViewController(DetailsViewController(selectedWord: selectedWord), animated: true)
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
        if let searchedWord = searchBar.searchTextField.text  {
            wordManager.fetchInputWord(inputWord: searchedWord.lowercased())
        }
        
    }

}

extension HomeViewController: WordManegerDelegate {
    
    func didUpdateWord(_ wordManager: WordManager, word: Word) {
        DispatchQueue.main.async {
            self.refreshCard(word: word)
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
            self.wordsTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
