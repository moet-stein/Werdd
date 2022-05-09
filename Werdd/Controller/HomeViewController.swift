//
//  ViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 08.03.22.
//

import UIKit
import Network

class HomeViewController: UIViewController {
    let monitor = NWPathMonitor()
    var wordManager = WordManager()
    
//    private var viewModel: WordsViewModel?
    
    private var fetchedWord = SingleResult(word: "")
    private var words = [SingleResult]()
    
    // MARK: - views
    private var contentView: HomeView!
    private var viewFavoritesButton: IconButton!
    
    private var cardSpinner: UIActivityIndicatorView!
    private var tableViewSpinner: UIActivityIndicatorView!
    
    private var wordLabel: UILabel!
    private var categoryImageView: CategoryImage!
    private var definitionLabel: UILabel!
    
    private var randomWordButton: IconButton!
    private var seeDetailsButton: IconButton!
    private var wordsTableView: UITableView!
    
    private var searchBar:UISearchBar!
    
    private var noWordFoundInTableView: NoWordFoundView!
    private var noWordFoundInRandomCard: NoWordFoundView!
    
    private var noInternetView: UIView!
    
//    init(viewModel: WordsViewModel?) {
////        self.viewModel = viewModel
//
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.wordsTableView.indexPathForSelectedRow{
            self.wordsTableView.deselectRow(at: index, animated: true)
        }
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordManager.delegate = self
        
        contentView = HomeView()
        view = contentView
        
        viewFavoritesButton = contentView.viewFavoritesButton
        
        cardSpinner = contentView.cardSpinner
        tableViewSpinner = contentView.tableViewSpinner
        
        wordLabel = contentView.wordLabel
        categoryImageView = contentView.categoryImageView
        definitionLabel = contentView.definitionLabel
        
        randomWordButton = contentView.randomWordButton
        seeDetailsButton = contentView.seeDetailsButton
        
        wordsTableView = contentView.wordsTableView
        wordsTableView.delegate = self
        wordsTableView.dataSource = self

        
        searchBar = contentView.searchBar
        searchBar.delegate = self
        wordsTableView.tableHeaderView = searchBar
        
        noWordFoundInTableView = contentView.noWordFoundInTableView
        noWordFoundInRandomCard = contentView.noWordFoundInRandomCard
        
        noInternetView = contentView.noInternetView
        
        
        tableViewSpinner.startAnimating()
        cardSpinner.startAnimating()
        wordManager.fetchInputWord(inputWord: "grateful")
        wordManager.fetchRandomWord()
        
        addButtonsTarget()
        
        checkInternetConnection()
    }
    
    private func checkInternetConnection() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self?.noInternetView.isHidden = true
                }
            } else {
                DispatchQueue.main.async {
                    self?.noInternetView.isHidden = false
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func addButtonsTarget() {
        randomWordButton.addTarget(self, action: #selector(randomWordButtonTapped), for: .touchUpInside)
        viewFavoritesButton.addTarget(self, action: #selector(viewFavoritesButtonTapped), for: .touchUpInside)
        seeDetailsButton.addTarget(self, action: #selector(seeDetailsButtonTapped), for: .touchUpInside)
    }
    
    private func refreshCard(word: Word) {
        let word = word
        wordLabel.text = word.word
        
        let randomResult = word.results?.randomElement()
        let singleResult = SingleResult(word: word.word, result: randomResult)
        fetchedWord = singleResult
        
        if let category = singleResult.result?.partOfSpeech {
            categoryImageView.isHidden = false
            categoryImageView.image = UIImage(named: category)
        } else {
            categoryImageView.isHidden = true
        }
        
        if let definition =  singleResult.result?.definition {
            definitionLabel.text = definition
        } else {
            definitionLabel.text = "No definition found for this word"
        }
        
        wordLabel.zoomIn(duration: 0.5)
        categoryImageView.zoomIn(duration: 0.5)
        definitionLabel.zoomIn(duration: 0.5)
    }
    

    @objc func randomWordButtonTapped() {
        cardSpinner.startAnimating()
        randomWordButton.isUserInteractionEnabled = false
        wordManager.fetchRandomWord()
    }
    
    @objc func viewFavoritesButtonTapped() {
        navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
    
    @objc func seeDetailsButtonTapped() {
        navigationController?.pushViewController(DetailsViewController(passedFavWord: nil, selectedWord: fetchedWord), animated: true)
    }
}



extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
//        return viewModel?.numberOfRowsInSection ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordsTableViewCell.identifier, for: indexPath) as? WordsTableViewCell else {
            return UITableViewCell()
        }
//        let wordDetail = viewModel.words
        let wordForRow = words[indexPath.row]
        
        cell.viewModel = WordCellViewModel(wordDetail: wordForRow)
        
//        cell.setupCellContent(image: wordForRow.result?.partOfSpeech, word: wordForRow.word, definition: wordForRow.result?.definition)
        
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
        tableViewSpinner.startAnimating()
        searchBar.endEditing(true)
        wordsTableView.isUserInteractionEnabled = false
        if let searchedWord = searchBar.searchTextField.text  {
            wordManager.fetchInputWord(inputWord: searchedWord.lowercased())
        }
        
    }

}

extension HomeViewController: WordManegerDelegate {
    
    func didUpdateWord(_ wordManager: WordManager, word: Word) {
        DispatchQueue.main.async {
            self.wordLabel.isHidden = false
            self.definitionLabel.isHidden = false
            self.categoryImageView.isHidden = false
            self.noWordFoundInRandomCard.isHidden = true
            
            self.refreshCard(word: word)
            self.cardSpinner.stopAnimating()
            self.randomWordButton.isUserInteractionEnabled = true
        }
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
