//
//  DetailsView.swift
//  Werdd
//
//  Created by Moe Steinmueller on 04.04.22.
//

import UIKit

class DetailsView: UIView {
    private var selectedWord: String
    
    private let testLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "LeagueSpartan-Bold", size: 30)
        label.textColor = UIColor(named: "DarkGreen")
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    private let outerStackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 30
        view.backgroundColor = .white
//        view.distributi
        return view
    }()
    
    private let definitionCard: DetailsCardView = {
       let view = DetailsCardView(bgColorName: "LightGreen", cardHeight: 150, bottomLabelText: "Definition")
        return view
    }()
    
    private let synonymsCard: DetailsCardView = {
        let view = DetailsCardView(bgColorName: "DarkGreen", cardHeight: 100, bottomLabelText: "Synonyms")
        return view
    }()
    
    private let antonymsCard: DetailsCardView = {
       let view = DetailsCardView(bgColorName: "SoftBrown", cardHeight: 100, bottomLabelText: "Antonyms")
        return view
    }()
    
    private let usageCard: DetailsCardView = {
        let view = DetailsCardView(bgColorName: "MatchaGreen", cardHeight: 180, bottomLabelText: "Example Usage")
        return view
    }()
    
    init(selectedWord: String) {
        self.selectedWord = selectedWord
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: "ViewLightYellow")
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        testLabel.text = selectedWord
        addSubview(testLabel)
        addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            testLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            testLabel.heightAnchor.constraint(equalToConstant: 50),
            
            outerStackView.topAnchor.constraint(equalTo: testLabel.bottomAnchor, constant: 20),
            outerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            outerStackView.heightAnchor.constraint(equalToConstant: 500),
            outerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70)
        ])
        
        outerStackView.addArrangedSubview(definitionCard)
        outerStackView.addArrangedSubview(synonymsCard)
        outerStackView.addArrangedSubview(antonymsCard)
        outerStackView.addArrangedSubview(usageCard)
    }
}
