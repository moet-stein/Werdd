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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView = HomeView()
        view = contentView

        viewFavoritesButton = contentView.viewFavoritesButton
        noInternetView = contentView.noInternetView
        topContainerView = contentView.topContainerView
        bottomContainerView = contentView.bottomContainerView
        setVCs()
        addButtonsTarget()
        checkInternetConnection()
    }
    
    private func setVCs() {
        let randomWordVC = RandomWordViewController()
        addChild(randomWordVC)
        topContainerView.addSubview(randomWordVC.view)
        randomWordVC.didMove(toParent: self)
        randomWordVC.view.frame = topContainerView.frame
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

