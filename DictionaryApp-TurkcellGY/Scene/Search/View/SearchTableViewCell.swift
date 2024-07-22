//
//  SearchTableViewCell.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 22.07.2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchTableViewCell"
    
    //MARK: - UIElements
    let partOfSpeechLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "partOfSpeechLabel"
        label.textColor = .buttonCL
        label.font = .systemFont(ofSize: 18, weight: .black)
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "definitionLabeldefinitionLabeldefinitionLabeldefinitionLabeldefinitionLabeldefinitionLabel"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let exampleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Example"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let exampleResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "exampleResultLabel"
        label.textColor = .placeholderText
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    //MARK: - İnit Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SetupUI
extension SearchTableViewCell {
    func SetupUI() {
        addSubview(partOfSpeechLabel)
        addSubview(definitionLabel)
        addSubview(exampleLabel)
        addSubview(exampleResultLabel)
        
        NSLayoutConstraint.activate([
            partOfSpeechLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            partOfSpeechLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            partOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            definitionLabel.topAnchor.constraint(equalTo: partOfSpeechLabel.bottomAnchor, constant: 15),
            definitionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor,constant: -30),

            
            exampleLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 15),
            exampleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            exampleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),

            
            
            exampleResultLabel.topAnchor.constraint(equalTo: exampleLabel.bottomAnchor, constant: 15),
            exampleResultLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            exampleResultLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),

        ])
    }
}

