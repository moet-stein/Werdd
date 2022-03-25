//
//  ViewController.swift
//  Werdd
//
//  Created by Moe Steinmueller on 08.03.22.
//

import UIKit

class ViewController: UIViewController {
    
   
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
    }
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    
    override func loadView() {
        print("loadView")
        view = ContentView(frame: .zero)
    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}


