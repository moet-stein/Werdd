//
//  CategoryImage.swift
//  Werdd
//
//  Created by Moe Steinmueller on 30.03.22.
//

import UIKit

class CategoryImage: UIImageView {

    var size: CGFloat
    
    init(size: CGFloat, frame: CGRect = .zero) {
        self.size = size
        super.init(frame: frame)
        self.setUpUI(size: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        heightAnchor.constraint(equalToConstant: size).isActive = true
        widthAnchor.constraint(equalToConstant: size).isActive = true
        layer.cornerRadius = size / 2
        clipsToBounds = true
    }
    
    func addBorder() {
        layer.borderWidth = 0.7
        layer.borderColor = UIColor(named: "DarkGreen")?.cgColor
    }

}
