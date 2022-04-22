//
//  DetailsViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class DetailsViewController: UIViewController {
    private var contentView: DetailsView!
    private var selectedWord: SingleResult
    
    private var favoriteButton: IconButton!
    
    override func loadView() {
        contentView = DetailsView(selectedWord: selectedWord)
        view = contentView
        
        favoriteButton = contentView.favoriteButton
        addButtonTarget()
    }
    
    private func addButtonTarget() {
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }
    
    @objc func favoriteTapped(sender: UIButton) {
        let button = sender as! IconButton
        
        sender.isSelected = !sender.isSelected
        
        button.toggleFavorite()
        
    }
    
    init(selectedWord: SingleResult) {
        self.selectedWord = selectedWord
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
