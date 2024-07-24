//
//  DetailView.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 23.07.2024.
//

import Foundation
import UIKit

class DetailView: UIView {
    
    //MARK: - UIElements
    let detailControllerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let synonymContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .placeholderText
        return view
    }()
    
    let synonymCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
    }
}

//MARK: - SetupUI
extension DetailView {
    func setupUI() {
        backgroundColor = .white
        addSubview(detailControllerCollectionView)
        addSubview(synonymContentView)
        synonymContentView.addSubview(synonymCollectionView)
        
        NSLayoutConstraint.activate([
            detailControllerCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            detailControllerCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            detailControllerCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            detailControllerCollectionView.bottomAnchor.constraint(equalTo: synonymContentView.topAnchor),
            
            synonymContentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            synonymContentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            synonymContentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            synonymContentView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
            
            synonymCollectionView.topAnchor.constraint(equalTo: synonymContentView.topAnchor,constant: 15),
            synonymCollectionView.leadingAnchor.constraint(equalTo: synonymContentView.leadingAnchor),
            synonymCollectionView.trailingAnchor.constraint(equalTo: synonymContentView.trailingAnchor),
            synonymCollectionView.bottomAnchor.constraint(equalTo: synonymContentView.bottomAnchor,constant: -15)
        ])
    }
}
