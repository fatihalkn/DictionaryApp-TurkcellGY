//
//  SearchView.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 22.07.2024.
//

import Foundation
import UIKit

class SearchView: UIView {
    
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
    
    //MARK: - UIElements
    
    let searchController = UISearchController()
    let searchButton = SearchButton()
    
    let recentSearhLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent search"
        label.textColor = .placeholderText
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let recentSearchWordCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
}

//MARK: - SetupUI
extension SearchView {
    func setupUI() {
        backgroundColor = .white
        searchButton.buttonConfigure(model: SearchButtonModel(buttonLabel: "Search"))
        addSubview(searchButton)
        addSubview(recentSearhLabel)
        addSubview(recentSearchWordCollectionView)
        
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            searchButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            searchButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 60),
            
            recentSearhLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            recentSearhLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            recentSearhLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            recentSearchWordCollectionView.topAnchor.constraint(equalTo: recentSearhLabel.bottomAnchor, constant: 15),
            recentSearchWordCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 15),
            recentSearchWordCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            recentSearchWordCollectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)

        ])
    }
}
