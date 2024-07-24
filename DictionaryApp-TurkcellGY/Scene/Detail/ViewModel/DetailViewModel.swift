//
//  DetailViewModel.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 23.07.2024.
//

import Foundation

class DetailViewModel {
    
    var wordService: WordService = NetworkService()
    var originalWordDetail = [WordDetailResponseModel]()
    var filteredWordDetail = [WordDetailResponseModel]()
    var wordTitle: String?
    var wordText: String?
    var partOfSpeechModel: [PartOfSpeechModel] = [.init(partOfSpeechModel: "Noun", type: .Noun),
                                                  .init(partOfSpeechModel: "Verb", type: .Verb),
                                                  .init(partOfSpeechModel: "Adjective", type: .Adjective)]
}
