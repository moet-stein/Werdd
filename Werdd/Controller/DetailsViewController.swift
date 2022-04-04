//
//  DetailsViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class DetailsViewController: UIViewController {
    private var contentView: DetailsView!
    private var selectedWord: String

    override func loadView() {
        contentView = DetailsView(selectedWord: selectedWord)
        view = contentView
    }
    
    init(selectedWord: String) {
        self.selectedWord = selectedWord
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
