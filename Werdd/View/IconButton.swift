//
//  IconButton.swift
//  Werdd
//
//  Created by Moe Steinmueller on 18.03.22.
//

import UIKit

class IconButton: UIButton {
    
    var size: CGFloat
    var systemName: String
    var iconColor: UIColor
    var completion: (() -> Void)?
    
    init(size: CGFloat, systemName: String, iconColor: UIColor, completion: (() -> Void)?, frame: CGRect = .zero) {
        self.size = size
        self.systemName = systemName
        self.iconColor = iconColor
        self.completion = completion
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: .bold, scale: .medium)
        let randomImage = UIImage(systemName: systemName, withConfiguration: config)
        tintColor = iconColor
        setImage(randomImage, for: .normal)
        
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        completion?()
    }
    
}
