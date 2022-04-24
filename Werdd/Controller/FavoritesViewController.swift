//
//  FavoritesViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 24.04.22.
//

import UIKit

class FavoritesViewController: UIViewController {
    private var contentView: FavoritesView!

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = FavoritesView()
        view = contentView

    }
    
    init() {
       
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
