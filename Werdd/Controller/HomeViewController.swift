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

    var wordManager: NetWorkingProtocol!
    
    private var fetchedWord: WordViewModel?
    private var wordVM = [WordViewModel]()
    
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
    
    private var searchBar: UISearchBar!
    
    private var noWordFoundInTableView: NoWordFoundView!
    private var noWordFoundInRandomCard: NoWordFoundView!
    
    private var noInternetView: UIView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.wordsTableView.indexPathForSelectedRow{
            self.wordsTableView.deselectRow(at: index, animated: true)
        }
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        

    }
    
    init(wordManager: NetWorkingProtocol) {
        self.wordManager = wordManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        searchBar.delegate = self
        
        fetchRandom()
        fetchSearchedWords(inputWord: "grateful")
        addButtonsTarget()
        checkInternetConnection()
        addKeyBoardNotificationCenter()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setViews() {
        contentView = HomeView()
        view = contentView
        
        viewFavoritesButton = contentView.viewFavoritesButton
        
        cardSpinner = contentView.cardSpinner
        tableViewSpinner = contentView.tableViewSpinner
        cardSpinner.startAnimating()
        tableViewSpinner.startAnimating()
        
        wordLabel = contentView.wordLabel
        categoryImageView = contentView.categoryImageView
        definitionLabel = contentView.definitionLabel
        categoryImageView.isHidden = true
        
        randomWordButton = contentView.randomWordButton
        seeDetailsButton = contentView.seeDetailsButton
        
        wordsTableView = contentView.wordsTableView
        wordsTableView.estimatedRowHeight = 100
        wordsTableView.rowHeight = UITableView.automaticDimension
        
        searchBar = contentView.searchBar
        wordsTableView.tableHeaderView = searchBar
        
        noWordFoundInTableView = contentView.noWordFoundInTableView
        noWordFoundInRandomCard = contentView.noWordFoundInRandomCard
        
        noInternetView = contentView.noInternetView
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
    
    private func addButtonsTarget() {
        randomWordButton.addTarget(self, action: #selector(randomWordButtonTapped), for: .touchUpInside)
        viewFavoritesButton.addTarget(self, action: #selector(viewFavoritesButtonTapped), for: .touchUpInside)
        seeDetailsButton.addTarget(self, action: #selector(seeDetailsButtonTapped), for: .touchUpInside)
    }
    
    private func fetchRandom() {
        wordManager.fetchGenericData(urlString: "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions", type: Word.self) { [weak self] result in
            switch result {
            case .success(let word):
                let randomResult = word.results?.randomElement()
                let singleResult = SingleResult(uuid: UUID(), word: word.word, result: randomResult)
                DispatchQueue.main.async {
                    self?.refreshCard(word: WordViewModel(word: SingleResult(uuid: UUID(), word: singleResult.word, result: singleResult.result)))
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.showRandomWordNotFound()
                }
            }
        }
    }
    
    private func fetchSearchedWords(inputWord: String) {
        self.wordVM = [WordViewModel]()

        let trimmed = inputWord.trimmingCharacters(in: .whitespacesAndNewlines)
        let convertedUrlQuery = trimmed.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        let urlString = "https://wordsapiv1.p.rapidapi.com/words/\(convertedUrlQuery)"
        
        wordManager.fetchGenericData(urlString: urlString, type: Word.self) { [weak self] result in
            switch result {
            case .success(let word):
                DispatchQueue.main.async {
                    if let results = word.results {
                        for result in results {
                            self?.wordVM.append(WordViewModel(word: SingleResult(uuid: UUID(), word: word.word, result: result)))
                        }
                        self?.noWordFoundInTableView.isHidden = true

                    }  else {
                        self?.wordVM = []
                        self?.noWordFoundInTableView.isHidden = false
                    }

                    self?.wordsTableView.reloadData()
                    self?.tableViewSpinner.stopAnimating()
                    self?.wordsTableView.isUserInteractionEnabled = true
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.showSearchedWordNoWordFound()
                }
            }
        }
    }
    
    private func refreshCard(word: WordViewModel) {
        fetchedWord = word
        wordLabel.text = word.word
        
        
        
        if let category = word.result?.partOfSpeech {
            categoryImageView.isHidden = false
            categoryImageView.image = UIImage(named: category)
        } else {
            categoryImageView.isHidden = true
        }
        
        if let definition =  word.result?.definition {
            definitionLabel.text = definition
        } else {
            definitionLabel.text = "No definition found for this word"
        }
        
        wordLabel.zoomIn(duration: 0.5)
        categoryImageView.zoomIn(duration: 0.5)
        definitionLabel.zoomIn(duration: 0.5)
        
        self.cardSpinner.stopAnimating()
        self.randomWordButton.isUserInteractionEnabled = true
    }
    
    private func showRandomWordNotFound() {
        wordLabel.isHidden = true
        definitionLabel.isHidden = true
        categoryImageView.isHidden = true
        noWordFoundInRandomCard.isHidden = false
        cardSpinner.stopAnimating()
        randomWordButton.isUserInteractionEnabled = true
    }
    
    private func showSearchedWordNoWordFound() {
        wordVM = []
        wordsTableView.reloadData()
        noWordFoundInTableView.isHidden = false
        tableViewSpinner.stopAnimating()
        wordsTableView.isUserInteractionEnabled = true
    }
    

    @objc func randomWordButtonTapped() {
        randomWordButton.isUserInteractionEnabled = false
        cardSpinner.startAnimating()
        fetchRandom()
    }
    
    @objc func viewFavoritesButtonTapped() {
        navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
    
    @objc func seeDetailsButtonTapped() {
        navigationController?.pushViewController(DetailsViewController(selectedWord: fetchedWord), animated: true)
    }
    
    private func addKeyBoardNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.bounds.origin.y == 0 {
                print(keyboardSize.height)
                self.view.bounds.origin.y += keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.bounds.origin.y != 0 {
                self.view.bounds.origin.y -= keyboardSize.height
            }
        }
    }
}



extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordsTableViewCell.identifier, for: indexPath) as? WordsTableViewCell else {
            return UITableViewCell()
        }
        
        let searchedWordVM = wordVM[indexPath.row]
        cell.searchedWordVM = searchedWordVM
        cell.backgroundColor = UIColor(named: "ViewLightYellow")
        tableView.separatorStyle = .none
        
        return cell
        
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord = wordVM[indexPath.row]
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
        wordsTableView.isUserInteractionEnabled = false
        tableViewSpinner.startAnimating()
        if let searchedWord = searchBar.searchTextField.text  {
            fetchSearchedWords(inputWord: searchedWord)
        }
        
    }

}
