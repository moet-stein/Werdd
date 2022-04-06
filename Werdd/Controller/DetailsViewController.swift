//
//  DetailsViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class DetailsViewController: UIViewController {
    private var contentView: DetailsView!
    private var selectedWord: WordDetail

    override func loadView() {
        contentView = DetailsView(selectedWord: selectedWord)
        view = contentView
        
//        navigationItem.title = selectedWord.word
//        navigationController?.navigationBar.barTintColor = UIColor(named: "LightGreen")
//        
//
//        let attributes = [
//            NSAttributedString.Key.foregroundColor: UIColor(named: "DarkGreen"),
////            NSAttributedString.Key.font: UIFont(name: "LeagueSpartan-Bold", size: 28),
//        ]
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    init(selectedWord: WordDetail) {
        self.selectedWord = selectedWord
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
