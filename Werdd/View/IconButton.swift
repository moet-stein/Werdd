//
//  IconButton.swift
//  Werdd
//
//  Created by Moe Steinmueller on 18.03.22.
//

import UIKit

class IconButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.size.height / 2
        clipsToBounds = true
    }

    //designated initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //xcode needs this
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(size: CGFloat, systemName: String, tintColor: UIColor) {
        self.init(frame: .zero)
        
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: .bold, scale: .medium)
        let randomImage = UIImage(systemName: systemName,withConfiguration: config)
        self.tintColor =  tintColor
        self.setImage(randomImage, for: .normal)
    }

}
