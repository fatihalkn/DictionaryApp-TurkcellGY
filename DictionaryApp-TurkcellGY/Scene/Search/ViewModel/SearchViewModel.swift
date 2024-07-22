//
//  SearchViewModel.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 22.07.2024.
//

import Foundation

class SearchViewModel {
    var wordService: WordService = NetworkService()
    var wordDetail = [WordDetailResponseModel]()
    
    func getDetailWord(word: String,completion: @escaping (() -> Void )) {
        
        wordService.getWordDetail(word: word) { result in
            switch result {
            case .success(let wordDetailResponse):
                self.wordDetail = wordDetailResponse
                print(wordDetailResponse)
                completion()
            case .failure(let failure):
                completion()
                print("ERROR: \(failure)")
            }
        }
    }
}
