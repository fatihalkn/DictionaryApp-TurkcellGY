//
//  DetailCollectionViewHeader.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 23.07.2024.
//

import UIKit
import AVFoundation

protocol DetailCollectionViewHeaderProtocol {
    func updateCollectionView()
    func didTappedVoiceButton()
}

class DetailCollectionViewHeader: UICollectionReusableView {
    static let identifier = "DetailCollectionViewHeader"
    
    //MARK: - Properties
    var detailViewModel: DetailViewModel!
    var selectedPartOfSpeechTypes: [PartOfSpeechType] = []
    var detailCollectionViewHeaderDelegate: DetailCollectionViewHeaderProtocol?
    
    
    
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
    
    let voiceButton: UIButton = {
        let button = UIButton()
        button.setImage(.audioWave, for: .normal)
        button.tintColor = .white
        button.isPointerInteractionEnabled = true
        button.backgroundColor = .clear
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
        voiceButtonAction()
        
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
    
    func addCell() {
        if detailViewModel.partOfSpeechModel.count == 3 {
            let closeCell = PartOfSpeechModel(partOfSpeechModel: "X", type: .Close)
            detailViewModel.partOfSpeechModel.insert(closeCell, at: 0)
            partOfSpeechCollectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
        } else {
            return
        }
    }
    
    func updateFilterWordCollectionView(data: [WordDetailResponseModel]) {
        detailViewModel.filteredWordDetail = data
        detailCollectionViewHeaderDelegate?.updateCollectionView()
    }
    
    func voiceButtonAction() {
        voiceButton.addTarget(self, action: #selector(voiceButtonTapped), for: .touchUpInside)
    }
    
    @objc func voiceButtonTapped() {
        detailCollectionViewHeaderDelegate?.didTappedVoiceButton()
        
        
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
        let isSelected = selectedPartOfSpeechTypes.contains(where: { $0 == model.type })
        cell.selectCell(isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let partOfSpeechType = detailViewModel.partOfSpeechModel[indexPath.item].type
        switch partOfSpeechType {
        case .Noun, .Verb, .Adjective:
            let cellWidth: CGFloat = collectionView.frame.width / 3
            let cellHeight: CGFloat = 40
            return CGSize(width: cellWidth, height: cellHeight)
        case .Close:
            let cellWidth: CGFloat = 40
            let cellHeight: CGFloat = 40
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let partOfSpeechType = detailViewModel.partOfSpeechModel[indexPath.item].type
        
        if partOfSpeechType != .Close {
            
            if selectedPartOfSpeechTypes.contains(where: { $0 == partOfSpeechType }) {
                if let indexToRemove = selectedPartOfSpeechTypes.firstIndex(where: { $0 == partOfSpeechType }) {
                    let cell = collectionView.cellForItem(at: indexPath) as! DetailHeaderViewCell
                    cell.selectCell(false)
                    selectedPartOfSpeechTypes.remove(at: indexToRemove)
                    
                    if selectedPartOfSpeechTypes.isEmpty {
                        updateFilterWordCollectionView(data: detailViewModel.originalWordDetail)
                        removeXButton()
                    } else {
                        deleteMeanings(type: partOfSpeechType)
                    }
                }
            } else {
                selectedPartOfSpeechTypes.append(partOfSpeechType)
                let cell = collectionView.cellForItem(at: indexPath) as! DetailHeaderViewCell
                cell.selectCell(true)
                filterMeanings()
            }
            
        } else {
            removeXButton()
        }
    }
    
    func removeXButton() {
        if let xCellIndex = detailViewModel.partOfSpeechModel.firstIndex(where: { $0.type == .Close }) {
            let collectionView = partOfSpeechCollectionView
            let indexPath = IndexPath(item: xCellIndex, section: 0)
            
            selectedPartOfSpeechTypes.forEach { selectedSpeechType in
                if let cellIndex = detailViewModel.partOfSpeechModel.firstIndex(where: { $0.type == selectedSpeechType }) {
                    let selectedIndexPath = IndexPath(item: cellIndex, section: 0)
                    let cell = collectionView.cellForItem(at: selectedIndexPath) as! DetailHeaderViewCell
                    cell.selectCell(false)
                }
            }
            selectedPartOfSpeechTypes.removeAll()
            
            collectionView.performBatchUpdates {
                detailViewModel.partOfSpeechModel.remove(at: indexPath.item)
                collectionView.deleteItems(at: [indexPath])
            } completion: { _ in
                self.detailViewModel.filteredWordDetail = self.detailViewModel.originalWordDetail
                self.detailCollectionViewHeaderDelegate?.updateCollectionView()
            }
        }
    }
    
    func filterMeanings() {
        addCell()
        let filteredNouns = detailViewModel.originalWordDetail.compactMap { wordDetail in
            var newWordDetail = wordDetail
            newWordDetail.meanings.removeAll()
            
            var filteredMeanings: [Meaning] = []
            
            selectedPartOfSpeechTypes.forEach { selectedPartOfSpeechType in
                let meanings = wordDetail.meanings.filter { meaning in
                    return meaning.partOfSpeech == selectedPartOfSpeechType.rawValue
                }
                
                filteredMeanings.append(contentsOf: meanings)
            }

            
            newWordDetail.meanings.append(contentsOf: filteredMeanings)
            
            return newWordDetail
        }
        
        
        updateFilterWordCollectionView(data: filteredNouns)
    }
    
    func deleteMeanings(type: PartOfSpeechType) {
        let updatedNouns = detailViewModel.filteredWordDetail.compactMap { wordDetail in
            var newWordDetail = wordDetail
            
            if let indexToRemove = newWordDetail.meanings.firstIndex(where: { $0.partOfSpeech == type.rawValue }) {
                newWordDetail.meanings.remove(at: indexToRemove)
            }
            
            return newWordDetail
        }
        
        updateFilterWordCollectionView(data: updatedNouns)
    }
}

//MARK: - SetupUI
extension DetailCollectionViewHeader {
    func setupUI() {
        backgroundColor = .placeholderText
        addSubview(wordTitle)
        addSubview(wordText)
        addSubview(voiceButton)
        addSubview(partOfSpeechCollectionView)
        
        NSLayoutConstraint.activate([
            wordTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            wordTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            wordTitle.trailingAnchor.constraint(lessThanOrEqualTo: voiceButton.trailingAnchor, constant: -30),
            
            wordText.topAnchor.constraint(equalTo: wordTitle.bottomAnchor, constant: 10),
            wordText.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            wordText.trailingAnchor.constraint(lessThanOrEqualTo: voiceButton.trailingAnchor, constant: -30),
            
            
            voiceButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            voiceButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -10),
            voiceButton.widthAnchor.constraint(equalToConstant: 30),
            voiceButton.heightAnchor.constraint(equalToConstant: 30),
            
            partOfSpeechCollectionView.topAnchor.constraint(equalTo: wordText.bottomAnchor, constant: 5),
            partOfSpeechCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            partOfSpeechCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            partOfSpeechCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -5)
        ])
    }
}
