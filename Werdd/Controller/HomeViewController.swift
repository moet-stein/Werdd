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
    
    private let searchBar:UISearchBar = UISearchBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.wordsTableView.indexPathForSelectedRow{
            self.wordsTableView.deselectRow(at: index, animated: true)
        }
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func loadView() {
        contentView = HomeView()
        view = contentView
        
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        cell.setupCellContent(image: wordForRow.category, word: wordForRow.word, definition: wordForRow.definition)
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
            fetchInputWord(input: searchedWord.lowercased())
        }
        
    }

    func fetchInputWord(input: String) {
        guard let wordsURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/\(input)") else {
            print("Invalid URL")
            return
        }
        
        let apiKey = WORDSAPI_KEY
        
        var urlRequest = URLRequest(url: wordsURL)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("wordsapiv1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        urlRequest.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
                

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let words = try JSONDecoder().decode(Word.self, from: data)
                print(words)
            } catch {
                print("Failed to convert \(error.localizedDescription)")
            }
        }.resume()
    }
}
