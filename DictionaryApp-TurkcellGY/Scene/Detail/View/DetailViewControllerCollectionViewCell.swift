//
//  DetailViewControllerCollectionViewCell.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 23.07.2024.
//

import UIKit

class DetailViewControllerCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailViewControllerCollectionViewCell"
    
    //MARK: - UI Elements
    let partOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .buttonCL
        label.font = .systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let exampleTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Example"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let exampleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .placeholderText
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    //MARK: - Properties
    
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
    }
    
    func configureCell(model: Meaning) {
        partOfSpeechLabel.text = model.partOfSpeech.capitalized
        definitionLabel.text = model.definitions.first?.definition
        exampleLabel.text = model.definitions.first?.example
        
    }
}

//MARK: -  SetupUI
extension DetailViewControllerCollectionViewCell {
    func setupUI() {
        addSubview(partOfSpeechLabel)
        addSubview(definitionLabel)
        addSubview(exampleTitleLabel)
        addSubview(exampleLabel)
        
        NSLayoutConstraint.activate([
            partOfSpeechLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            partOfSpeechLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            partOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            definitionLabel.topAnchor.constraint(equalTo: partOfSpeechLabel.bottomAnchor, constant: 10),
            definitionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10),
            definitionLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            exampleTitleLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 10),
            exampleTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10),
            exampleTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            exampleLabel.topAnchor.constraint(equalTo: exampleTitleLabel.bottomAnchor, constant: 10),
            exampleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            exampleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            exampleLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
