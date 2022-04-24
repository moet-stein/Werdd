//
//  FavoritesViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 24.04.22.
//

import UIKit

class FavoritesViewController: UIViewController {
    private var favorites = [FavWord]()
    
    private var contentView: FavoritesView!
    
    private var favsTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "FAVORITES"
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "DarkGreen")!,
            NSAttributedString.Key.font: UIFont(name: "LeagueSpartan-Bold", size: 28)!
        ]

        self.navigationController?.navigationBar.titleTextAttributes = attrs
        
        DataManager.fetchFavWords { favs in
            if let favs = favs {
                favorites = favs
                
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
        
        print(favorites)
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
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordsTableViewCell.identifier, for: indexPath) as? WordsTableViewCell else {
            return UITableViewCell()
        }
        
        let wordForRow = favorites[indexPath.row]
        cell.setupCellContent(image: wordForRow.partOfSpeech, word: wordForRow.word, definition: wordForRow.definition)
        cell.backgroundColor = UIColor(named: "ViewLightYellow")
        tableView.separatorStyle = .none
        
        return cell
        
    }
}

extension FavoritesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord = favorites[indexPath.row]
        navigationController?.pushViewController(DetailsViewController(passedFavWord: selectedWord, selectedWord: nil), animated: true)
    }
}
