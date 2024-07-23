//
//  DetailViewController.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 23.07.2024.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    let detailView = DetailView()
    let detailViewModel = DetailViewModel()
    let detailHeaderView = DetailCollectionViewHeader()
    
    //MARK: - Lyfe Circle
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupRegister()
    }
    
    func setupRegister() {
        detailView.detailControllerCollectionView.register(DetailViewControllerCollectionViewCell.self, forCellWithReuseIdentifier: DetailViewControllerCollectionViewCell.identifier)
        detailView.detailControllerCollectionView.register(DetailCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailCollectionViewHeader.identifier)
    }
    
    func setupDelegate() {
        detailView.detailControllerCollectionView.delegate = self
        detailView.detailControllerCollectionView.dataSource = self
        
    }
}

//MARK: - Configure CollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let totalMeanings = detailViewModel.wordDetail.compactMap { $0.meanings }.flatMap{ $0 }
        return totalMeanings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailViewControllerCollectionViewCell.identifier, for: indexPath) as! DetailViewControllerCollectionViewCell
        let totalMeanings = detailViewModel.wordDetail.compactMap { $0.meanings }.flatMap{ $0 }
        let model = totalMeanings[indexPath.item]
        cell.configureCell(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 40
        let totalMeanings = detailViewModel.wordDetail.compactMap { $0.meanings }.flatMap{ $0 }
        let model = totalMeanings[indexPath.item]
        
        let partOfSpeechHeight = heightforLabel(text: model.partOfSpeech, width: cellWidth, font: .systemFont(ofSize: 18, weight: .black))
        let definitionHeight = heightforLabel(text: model.definitions.first?.definition ?? "BOŞ N/A", width: cellWidth, font: .systemFont(ofSize: 15, weight: .semibold))
       
        let exampleTitleHeight = heightforLabel(text: model.definitions.first?.example ?? "BOŞ N/A", width: cellWidth , font: .systemFont(ofSize: 15, weight: .semibold))
        
        let exapleHeight = heightforLabel(text: model.definitions.first?.example ?? "BOŞ N/A", width: cellWidth , font: .systemFont(ofSize: 15, weight: .semibold))
        
        let totalHeight = partOfSpeechHeight + definitionHeight + exampleTitleHeight + exapleHeight + (10 + 10 + 10 + 10)
        
        return.init(width: cellWidth, height: totalHeight)
    }
    
    //MARK: - Dynamic Height Cell
    func heightforLabel(text:String,width: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    //MARK: - Configure CollectionViewHeader
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCollectionViewHeader.identifier, for: indexPath) as! DetailCollectionViewHeader
            header.wordTitle.text = detailViewModel.wordTitle
            header.wordText.text = detailViewModel.wordText
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: view.frame.size.width, height: view.frame.size.height / 6 )
        }
}

