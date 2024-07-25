//
//  SearchViewModel.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 22.07.2024.
//

import Foundation

protocol SearchViewModelProtocol {
    func showLoading()
    func removeLoading()
}

class SearchViewModel {
    var wordService: WordService = NetworkService()
    var searchViewModelDelegate: SearchViewModelProtocol?
    var wordDetail = [WordDetailResponseModel]()
    var savedWord = [Word]()
    
    func getDetailWord(word: String,completion:  @escaping  (() -> Void )) {
        searchViewModelDelegate?.showLoading()
        wordService.getWordDetail(word: word) { result in
            switch result {
            case .success(let wordDetailResponse):
                self.wordDetail = wordDetailResponse
                completion()
                self.searchViewModelDelegate?.removeLoading()
            case .failure(let failure):
                completion()
                print("ERROR: \(failure)")
            }
        }
    }
    
    func saveWordCoreData(searchWord: String) {
        CoreDataManager.shared.saveWord(searchWord: searchWord )
    }
    
    func fetchWordCoreData() {
        guard let word = CoreDataManager.shared.fetchWord() else { return }
        self.savedWord = word
    }
}
