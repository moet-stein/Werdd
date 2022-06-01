//
//  FavoritesViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 24.04.22.
//

import UIKit

class FavoritesViewController: UIViewController {
    private var searchedWordVM = [SearchedWordViewModel]()
    
    private var contentView: FavoritesView!
    
    private var favsTableView: UITableView!
    private var noFavFoundView: NotFoundWithImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "FAVORITES"
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "DarkGreen")!,
            NSAttributedString.Key.font: UIFont(name: "LeagueSpartan-Bold", size: 28)!
        ]

        self.navigationController?.navigationBar.titleTextAttributes = attrs
        self.navigationController?.navigationBar.backItem?.title = "Home"
        
        DataManager.fetchFavWords { favs in
            if let favs = favs {
                
                if favs.isEmpty{
                    DispatchQueue.main.async {
                        self.noFavFoundView.isHidden = false
                    }
                }
                
                searchedWordVM = favs.map({return SearchedWordViewModel(words: $0)})
    
                DispatchQueue.main.async { [weak self] in
                    self?.favsTableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = FavoritesView()
        view = contentView
        
        favsTableView = contentView.favsTableView
        favsTableView.delegate = self
        favsTableView.dataSource = self
        
        noFavFoundView = contentView.noFavFoundView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FavoritesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedWordVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordsTableViewCell.identifier, for: indexPath) as? WordsTableViewCell else {
            return UITableViewCell()
        }
        
        let searchedWordVM = searchedWordVM[indexPath.row]
        cell.searchedWordVM = searchedWordVM
//        let wordForRow = favorites[indexPath.row]
//        cell.setupCellContent(image: wordForRow.result?.partOfSpeech, word: wordForRow.word, definition: wordForRow.result?.definition)
        cell.backgroundColor = UIColor(named: "ViewLightYellow")
        tableView.separatorStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
     
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let id = searchedWordVM[indexPath.row].uuid
            DataManager.deleteFavWord(usingID: id)
            searchedWordVM.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            if searchedWordVM.count == 0 {
                noFavFoundView.isHidden = false
            }
        }
    }
    
    
}

extension FavoritesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord = searchedWordVM[indexPath.row]
        navigationController?.pushViewController(DetailsViewController(selectedWord: selectedWord), animated: true)
    }
}
