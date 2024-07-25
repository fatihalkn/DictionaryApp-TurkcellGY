//
//  SearchViewController.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 22.07.2024.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    let searchView  = SearchView()
    let searchViewModel = SearchViewModel()
    
    //MARK: - Lyfe Circle
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        buttonActions()
        setupRegister()
        setupDelegate()
        searchView.recentSearchWordCollectionView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecentWordCoreData()
        searchView.recentSearchWordCollectionView.reloadData()
        
        
    }
    
    func fetchRecentWordCoreData() {
        searchViewModel.fetchWordCoreData()
    }
    
    
}

//MARK: - ButtonActions
extension SearchViewController {
    func buttonActions() {
        searchView.searchButton.addTarget(self, action: #selector(SearchButtonTapped), for: .touchUpInside)
    }
    
    @objc func SearchButtonTapped() {
        guard let word = searchView.searchController.searchBar.text else { return }
        
        if word.isEmpty {
            searchView.showError(text: "Please enter a word.", image: nil, interaction: false, delay: 2.5)
            return
        }
        
        self.searchViewModel.searchViewModelDelegate = self
        searchViewModel.getDetailWord(word: word) {
            let vc = DetailViewController()
            vc.detailViewModel.originalWordDetail = self.searchViewModel.wordDetail
            vc.detailViewModel.filteredWordDetail = self.searchViewModel.wordDetail
            vc.detailViewModel.wordTitle = word
            vc.detailViewModel.audioURL = self.searchViewModel.wordDetail.first?.phonetics.first?.audio
            vc.detailViewModel.wordText = self.searchViewModel.wordDetail.first?.phonetics.first?.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        searchViewModel.saveWordCoreData(searchWord: word)
    }
}

//MARK: - SetupSearchBar
extension SearchViewController {
    func setupSearchBar() {
        navigationItem.searchController = searchView.searchController
        searchView.searchController.delegate = self
        searchView.searchController.searchResultsUpdater = self
    }
}

//MARK: -  UISearchControllerDelegate
extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchView.recentSearchWordCollectionView.isHidden = false
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        searchView.recentSearchWordCollectionView.isHidden = true
        fetchRecentWordCoreData()
        searchView.recentSearchWordCollectionView.reloadData()
    }
    
}

//MARK: - SearchViewModelProtocol {
extension SearchViewController : SearchViewModelProtocol {
    func showLoading() {
        searchView.showLoading(text: "", type: .activityIndicator, interaction: false)
    }
    
    func removeLoading() {
        searchView.removeLoading()
    }
}
//MARK: - Configure CollectionView
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupRegister() {
        searchView.recentSearchWordCollectionView.register(RecentWordCollectionViewCell.self, forCellWithReuseIdentifier: RecentWordCollectionViewCell.identifier)
    }
    
    func setupDelegate() {
        searchView.recentSearchWordCollectionView.delegate = self
        searchView.recentSearchWordCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.savedWord.suffix(3).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentWordCollectionViewCell.identifier, for: indexPath) as! RecentWordCollectionViewCell
        let data = Array(searchViewModel.savedWord.suffix(3))[indexPath.item]
        cell.recentWordLabel.text = data.searchWord
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width
        let cellHeight: CGFloat = collectionView.frame.height / 5
        return .init(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! RecentWordCollectionViewCell
        guard let word = cell.recentWordLabel.text else { return }
        
        searchView.searchController.searchBar.text = cell.recentWordLabel.text
        
        self.searchViewModel.searchViewModelDelegate = self
        searchViewModel.getDetailWord(word: word) {
            let vc = DetailViewController()
            vc.detailViewModel.originalWordDetail = self.searchViewModel.wordDetail
            vc.detailViewModel.filteredWordDetail = self.searchViewModel.wordDetail
            vc.detailViewModel.wordTitle = word
            vc.detailViewModel.audioURL = self.searchViewModel.wordDetail.first?.phonetics.first?.audio
            vc.detailViewModel.wordText = self.searchViewModel.wordDetail.first?.phonetics.first?.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

