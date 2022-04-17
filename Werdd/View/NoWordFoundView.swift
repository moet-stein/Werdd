//
//  NoWordFoundView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 17.04.22.
//

import UIKit

class NoWordFoundView: UIView {
    
    var labelText: String
    
    private let noWordFoundLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 20)
        label.textColor = UIColor(named: "SoftBrown")
        label.textAlignment = .center
        return label
    }()

    init(labelText: String, frame: CGRect = .zero) {
        self.labelText = labelText
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        backgroundColor = UIColor(named: "CellBgGreen")
        noWordFoundLabel.text = labelText
        
        addSubview(noWordFoundLabel)
        
        NSLayoutConstraint.activate([
            noWordFoundLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noWordFoundLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noWordFoundLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

}
