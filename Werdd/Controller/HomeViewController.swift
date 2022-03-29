//
//  ViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 08.03.22.
//

import UIKit

class HomeViewController: UIViewController {
    var contentView: HomeView!
    
    override func loadView() {
        contentView = HomeView()
        
        view = contentView
    }
    
    
}



