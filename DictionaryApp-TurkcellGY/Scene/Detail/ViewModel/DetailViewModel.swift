//
//  DetailViewModel.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 23.07.2024.
//

import Foundation

class DetailViewModel {
    
    var wordDetail = [WordDetailResponseModel]()
    var wordTitle: String?
    var wordText: String?
    var partOfSpeechModel: [PartOfSpeechModel] = [.init(partOfSpeechModel: "Noun", type: .Noun),
                                                  .init(partOfSpeechModel: "Verb", type: .Verb),
                                                  .init(partOfSpeechModel: "Adjective", type: .Adjective)]

    func filterMeanings(partOfSpeech: PartOfSpeechType) -> [Meaning] {
        guard let firstWordDetail = wordDetail.first else { return [] }
        return firstWordDetail.meanings.filter { $0.partOfSpeech == partOfSpeech.rawValue}
    }
}
