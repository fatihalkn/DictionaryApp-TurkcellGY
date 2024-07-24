//
//  DetailViewController.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 23.07.2024.
//

import Foundation
import UIKit
import AVFoundation


class DetailViewController: UIViewController {
    
    //MARK: - Properties
    let detailView = DetailView()
    let detailViewModel = DetailViewModel()
    let detailHeaderView = DetailCollectionViewHeader()
    var player: AVAudioPlayer?
    
    
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
        
        detailView.synonymCollectionView.register(SynonymCollectionViewCell.self, forCellWithReuseIdentifier: SynonymCollectionViewCell.identifier)
        
    }
    
    func setupDelegate() {
        detailView.detailControllerCollectionView.delegate = self
        detailView.detailControllerCollectionView.dataSource = self
        
        detailView.synonymCollectionView.delegate = self
        detailView.synonymCollectionView.dataSource = self
        
        
    }
}

//MARK: - Configure CollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case detailView.detailControllerCollectionView:
            let totalMeanings = detailViewModel.filteredWordDetail.compactMap { $0.meanings }.flatMap{ $0 }
            return totalMeanings.count
        case detailView.synonymCollectionView:
            return detailViewModel.originalWordDetail.compactMap { $0.meanings.first?.synonyms }.flatMap { $0 }.count
        default:
            break
        }
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case detailView.detailControllerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailViewControllerCollectionViewCell.identifier, for: indexPath) as! DetailViewControllerCollectionViewCell
            let totalMeanings = detailViewModel.filteredWordDetail.compactMap { $0.meanings }.flatMap{ $0 }
            let model = totalMeanings[indexPath.item]
            cell.configureCell(model: model)
            return cell
        case detailView.synonymCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynonymCollectionViewCell.identifier, for: indexPath) as! SynonymCollectionViewCell
            let model = detailViewModel.originalWordDetail.compactMap { $0.meanings.first?.synonyms }.flatMap { $0 }[indexPath.item]
            cell.configureCell(model: model)
            return cell
        default:
            break
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case detailView.detailControllerCollectionView:
            let cellWidth: CGFloat = collectionView.frame.width - 40
            let totalMeanings = detailViewModel.filteredWordDetail.compactMap { $0.meanings }.flatMap{ $0 }
            let model = totalMeanings[indexPath.item]
            
            let partOfSpeechHeight = heightforLabel(text: model.partOfSpeech, width: cellWidth, font: .systemFont(ofSize: 18, weight: .black))
            let definitionHeight = heightforLabel(text: model.definitions.first?.definition ?? "BOŞ N/A", width: cellWidth, font: .systemFont(ofSize: 15, weight: .semibold))
            
            let exampleTitleHeight = heightforLabel(text: model.definitions.first?.example ?? "BOŞ N/A", width: cellWidth , font: .systemFont(ofSize: 15, weight: .semibold))
            
            let exapleHeight = heightforLabel(text: model.definitions.first?.example ?? "BOŞ N/A", width: cellWidth , font: .systemFont(ofSize: 15, weight: .semibold))
            
            let totalHeight = partOfSpeechHeight + definitionHeight + exampleTitleHeight + exapleHeight + (10 + 10 + 10 + 10)
            
            return.init(width: cellWidth, height: totalHeight)
            
        case detailView.synonymCollectionView:
            let cellWidth: CGFloat = collectionView.frame.width / 3
            let cellHeight: CGFloat = 40
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            break
        }
        return CGSize()
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
        if collectionView == detailView.detailControllerCollectionView && kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCollectionViewHeader.identifier, for: indexPath) as! DetailCollectionViewHeader
            header.detailViewModel = detailViewModel
            header.wordTitle.text = detailViewModel.wordTitle
            header.wordText.text = detailViewModel.wordText
            header.detailCollectionViewHeaderDelegate = self
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == detailView.detailControllerCollectionView {
            return CGSize(width: view.frame.size.width, height: view.frame.size.height / 6)
        }
        return CGSize.zero
    }
}

//MARK: - DetailCollectionViewHeaderProtocol
extension DetailViewController: DetailCollectionViewHeaderProtocol {
    func didTappedVoiceButton() {
        guard let audioUrl = detailViewModel.audioURL else {
            print("URL is nil")
            return
        }
        
        guard let url = URL(string: audioUrl) else {
            detailView.showError(text: "Audio not found. Please try again.", image: nil, interaction: false, delay: 2.5)
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading audio file: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                self.player = try AVAudioPlayer(data: data)
                self.player?.prepareToPlay()
                DispatchQueue.main.async {
                    self.player?.play()
                }
                print("Playing audio from URL: \(audioUrl)")
            } catch {
                print("Error initializing AVAudioPlayer: \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    
    
    
    func updateCollectionView() {
        detailView.detailControllerCollectionView.reloadData()
    }
}
