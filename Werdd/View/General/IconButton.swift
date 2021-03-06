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
    
    init(size: CGFloat, systemName: String, iconColor: UIColor, frame: CGRect = .zero) {
        self.size = size
        self.systemName = systemName
        self.iconColor = iconColor
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: .bold, scale: .medium)
        let randomImage = UIImage(systemName: systemName, withConfiguration: config)
        tintColor = iconColor
        setImage(randomImage, for: .normal)
    }
    
    
    func toggleFavorite() {
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .small)
        if isSelected {
            let heartSF = UIImage(systemName: "heart.fill", withConfiguration: config)
            setImage(heartSF, for: .selected)
        } else {
            let heartSF = UIImage(systemName: "heart", withConfiguration: config)
            setImage(heartSF, for: .normal)
        }
    }
    
    func rotateButton() {
        addTarget(self, action: #selector(rotatePressed), for: .touchUpInside)
    }
    
    func zoomInButton() {
        addTarget(self, action: #selector(zoomInPressed), for: .touchUpInside)
    }
    
    @objc func rotatePressed() {
        rotate()
    }
    @objc func zoomInPressed() {
        zoomIn()
    }
    
}

extension UIView {
    func zoomIn(duration: TimeInterval = 0.4) {
        self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    

    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.5
        
        self.layer.add(rotation, forKey: "rotationAnimation")
        
    }
}
