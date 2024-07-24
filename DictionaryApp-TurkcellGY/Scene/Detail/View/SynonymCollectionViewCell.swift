//
//  SynonymCollectionViewCell.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 24.07.2024.
//

import UIKit

class SynonymCollectionViewCell: UICollectionViewCell {
    static let identifier = "SynonymCollectionViewCell"
    
    
    //MARK: - UIElements
    let synonymLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .buttonCL
        label.font = .systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    //MARK: - İnit Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        
    }
    
    func configureCell(model: Meaning) {
        synonymLabel.text = model.synonyms.first
        
    }
 }

//MARK: - SetupUI
extension SynonymCollectionViewCell {
    func setupUI() {
        backgroundColor = .white
        addSubview(synonymLabel)
        NSLayoutConstraint.activate([
            synonymLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            synonymLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            synonymLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            synonymLabel.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor)
        ])
    }
}

