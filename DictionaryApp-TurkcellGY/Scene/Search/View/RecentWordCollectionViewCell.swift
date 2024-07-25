//
//  RecentWordCollectionViewCell.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 25.07.2024.
//

import UIKit

class RecentWordCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentWordCollectionViewCell"
    //MARK: - UIElements
    let recentWordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let rightArrawImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.clipsToBounds = true
        return imageView
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
extension RecentWordCollectionViewCell {
    func setupUI() {
        addSubview(searchImageView)
        addSubview(recentWordLabel)
        addSubview(rightArrawImageView)
        
        NSLayoutConstraint.activate([
            searchImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            searchImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 10),
            searchImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            recentWordLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            recentWordLabel.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 15),
            recentWordLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            recentWordLabel.trailingAnchor.constraint(lessThanOrEqualTo: rightArrawImageView.leadingAnchor, constant: -10),
            
            rightArrawImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            rightArrawImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -15),
            rightArrawImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -10)
            
         
            
            
        ])
    }
}
