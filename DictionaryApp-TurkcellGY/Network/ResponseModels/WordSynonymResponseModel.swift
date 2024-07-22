//
//  WordSynonymResponseModel.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 22.07.2024.
//

import Foundation

// MARK: - WordSynonymResponseModelElement
struct WordSynonymResponseModelElement: Codable {
    let word: String
    let score: Int
}

