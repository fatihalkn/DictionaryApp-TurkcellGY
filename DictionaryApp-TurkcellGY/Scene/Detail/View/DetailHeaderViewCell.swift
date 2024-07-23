//
//  DetailHeaderViewCell.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 23.07.2024.
//

import UIKit

class DetailHeaderViewCell: UICollectionViewCell {
    static let identifier = "DetailHeaderViewCell"
    
    //MARK: - UIElements
    let partOfSpeechLabel: UILabel = {
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
    
    func configureCell(model: PartOfSpeechModel) {
        partOfSpeechLabel.text = model.partOfSpeechModel
    }
}

//MARK: - SetupUI
extension DetailHeaderViewCell {
    func setupUI() {
        backgroundColor = .white
        addSubview(partOfSpeechLabel)
        NSLayoutConstraint.activate([
            partOfSpeechLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            partOfSpeechLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            partOfSpeechLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            partOfSpeechLabel.widthAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.widthAnchor)
        ])
    }
}
