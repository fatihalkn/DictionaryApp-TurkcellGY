//
//  WordService.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 22.07.2024.
//

import Foundation

protocol WordService {
    func getWordDetail(word:String,completion:@escaping (Result<[WordDetailResponseModel],Error>) -> Void)
}

extension NetworkService: WordService {
    func getWordDetail(word:String, completion: @escaping (Result<[WordDetailResponseModel], Error>) -> Void) {
        let url = NetworkEndPointHelper.shared.requestDetailWord(word: word)
        NetworkManager.shared.request(url: url, method: .get, completion: completion)
    }
}
