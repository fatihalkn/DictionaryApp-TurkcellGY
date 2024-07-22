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
    
}

//MARK: - SetupUI
extension SearchView {
    func setupUI() {
        backgroundColor = .white
        searchButton.buttonConfigure(model: SearchButtonModel(buttonLabel: "Search"))
        addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            searchButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            searchButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 60)

        ])
    }
}
