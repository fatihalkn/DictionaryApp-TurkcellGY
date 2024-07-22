//
//  SearchButton.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 22.07.2024.
//

import UIKit

final class SearchButton: UIButton {
    
    //MARK: - UIElements
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
        clipsToBounds = true
        
    }
    
    func buttonConfigure(model: SearchButtonModel) {
        buttonLabel.text = model.buttonLabel
    }
   
}

//MARK: - SetupUI
extension SearchButton {
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .buttonCL
        addSubview(buttonLabel)
        NSLayoutConstraint.activate([
            buttonLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            buttonLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            buttonLabel.widthAnchor.constraint(lessThanOrEqualTo:widthAnchor),
            buttonLabel.heightAnchor.constraint(lessThanOrEqualTo:heightAnchor)
        ])
    }
}
