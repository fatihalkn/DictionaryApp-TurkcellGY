//
//  PartOfSpeechModel.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 23.07.2024.
//

import Foundation

struct PartOfSpeechModel {
    let partOfSpeechModel: String
    let type: PartOfSpeechType
}

enum PartOfSpeechType: String {
    case Noun = "noun"
    case Verb = "verb"
    case Adjective = "adjective"
    case Close = "close"
}
