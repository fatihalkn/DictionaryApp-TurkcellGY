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
        
    }
}

//MARK: - ButtonActions
extension SearchViewController {
    func buttonActions() {
        searchView.searchButton.addTarget(self, action: #selector(SearchButtonTapped), for: .touchUpInside)
    }
    
    @objc func SearchButtonTapped() {
        guard let word = searchView.searchController.searchBar.text else { return }
        self.searchViewModel.searchViewModelDelegate = self
        searchViewModel.getDetailWord(word: word) {
            let vc = DetailViewController()
            vc.detailViewModel.originalWordDetail = self.searchViewModel.wordDetail
            vc.detailViewModel.filteredWordDetail = self.searchViewModel.wordDetail
            vc.detailViewModel.wordTitle = word
            vc.detailViewModel.wordText = self.searchViewModel.wordDetail.first?.phonetics.first?.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - SetupSearchBar
extension SearchViewController {
    func setupSearchBar() {
        navigationItem.searchController = searchView.searchController
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

