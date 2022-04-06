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
    private var wordsCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let index = self.wordsCollectionView.indexPathsForSelectedItems{
//            self.wordsCollectionView.deselectItem(at: index, animated: true)
//        }
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func loadView() {
        contentView = HomeView()
        view = contentView
        
        wordsCollectionView = contentView.wordsCollectionView
        wordsCollectionView.delegate = self
        wordsCollectionView.dataSource = self

//        wordsCollectionView.estimatedRowHeight = 100
//        wordsCollectionView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}



extension HomeViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordsCollectionViewCell.identifier, for: indexPath) as? WordsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let wordForRow = words[indexPath.row]
        cell.setupCellContent(image: wordForRow.category, word: wordForRow.word, definition: wordForRow.definition)
        cell.backgroundColor = UIColor(named: "ViewLightYellow")
        
        return cell
    }
}

extension HomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(words[indexPath.row].word)")
        let selectedWord = words[indexPath.row]
        navigationController?.pushViewController(DetailsViewController(selectedWord: selectedWord), animated: true)
    }
    
}
