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
    
    // MARK: - views
    private var contentView: HomeView!
    private var viewFavoritesButton: IconButton!
    private var noInternetView: UIView!
    private var topContainerView: UIView!
    private var bottomContainerView: UIView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        view.isUserInteractionEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView = HomeView()
        view = contentView

        viewFavoritesButton = contentView.viewFavoritesButton
        noInternetView = contentView.noInternetView
        topContainerView = contentView.topContainerView
        bottomContainerView = contentView.bottomContainerView
        
        addButtonsTarget()
        checkInternetConnection()
        
        setVCs()
        
        print("viewDidLoad HomeVC")
    }
    
    override func viewDidLayoutSubviews() {
//        setVCs()
    }
    
    
    private func setVCs() {
        let randomWordVC = RandomWordViewController()
        randomWordVC.view.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.addSubview(randomWordVC.view)
        addChild(randomWordVC)
        randomWordVC.didMove(toParent: self)
        randomWordVC.view.frame = topContainerView.frame
        
        let wordsTableVC = WordsTableViewController()
        wordsTableVC.view.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.addSubview(wordsTableVC.view)
        addChild(wordsTableVC)
        wordsTableVC.didMove(toParent: self)
        wordsTableVC.view.frame = bottomContainerView.frame
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func addButtonsTarget() {
        viewFavoritesButton.addTarget(self, action: #selector(viewFavoritesButtonTapped), for: .touchUpInside)
    }
    
    @objc func viewFavoritesButtonTapped() {
        navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
}

