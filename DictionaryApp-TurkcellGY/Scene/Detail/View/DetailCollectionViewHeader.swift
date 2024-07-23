//
//  DetailCollectionViewHeader.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 23.07.2024.
//

import UIKit

class DetailCollectionViewHeader: UICollectionReusableView {
    static let identifier = "DetailCollectionViewHeader"
    
    //MARK: - Properties
    let detailViewModel = DetailViewModel()
    
    //MARK: - UIElements
    let wordTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wordText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let voiceImageView: UIButton = {
        let button = UIButton()
        button.setImage(.audioWave, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let partOfSpeechCollectionView: UICollectionView = {
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
        setupDelegate()
        setupRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupRegister() {
        partOfSpeechCollectionView.register(DetailHeaderViewCell.self, forCellWithReuseIdentifier: DetailHeaderViewCell.identifier)
        
    }
    
    func setupDelegate() {
        partOfSpeechCollectionView.delegate = self
        partOfSpeechCollectionView.dataSource = self
    }
}

//MARK: - Configure CollectionView
extension DetailCollectionViewHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailViewModel.partOfSpeechModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailHeaderViewCell.identifier, for: indexPath) as! DetailHeaderViewCell
        let model = detailViewModel.partOfSpeechModel[indexPath.item]
        cell.configureCell(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width / 3
        let cellHeight: CGFloat = 40
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let partOfSpeechType = detailViewModel.partOfSpeechModel[indexPath.item].type
        switch partOfSpeechType {
        case .Noun: break
            
        case .Verb: break
            
        case .Adjective: break
            

        }
    }
    
    
}

//MARK: - SetupUI
extension DetailCollectionViewHeader {
    func setupUI() {
        backgroundColor = .placeholderText
        addSubview(wordTitle)
        addSubview(wordText)
        addSubview(voiceImageView)
        addSubview(partOfSpeechCollectionView)
        
        NSLayoutConstraint.activate([
            wordTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            wordTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            wordTitle.trailingAnchor.constraint(lessThanOrEqualTo: voiceImageView.trailingAnchor, constant: -30),
            
            wordText.topAnchor.constraint(equalTo: wordTitle.bottomAnchor, constant: 10),
            wordText.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            wordText.trailingAnchor.constraint(lessThanOrEqualTo: voiceImageView.trailingAnchor, constant: -30),

            
            voiceImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            voiceImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -10),
            voiceImageView.widthAnchor.constraint(equalToConstant: 30),
            voiceImageView.heightAnchor.constraint(equalToConstant: 30),
            
            partOfSpeechCollectionView.topAnchor.constraint(equalTo: wordText.bottomAnchor, constant: 10),
            partOfSpeechCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            partOfSpeechCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            partOfSpeechCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
