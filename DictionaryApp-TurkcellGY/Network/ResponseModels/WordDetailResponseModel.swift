//
//  WordDetailResponse.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 22.07.2024.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let wordDetailResponseModel = try? JSONDecoder().decode(WordDetailResponseModel.self, from: jsonData)

import Foundation

// MARK: - WordDetailResponseModelElement
struct WordDetailResponseModel: Codable {
    let word: String
    let phonetics: [Phonetic]
    var meanings: [Meaning]
    let license: License
    let sourceUrls: [String]
}

// MARK: - License
struct License: Codable {
    let name: String
    let url: String
}

// MARK: - Meaning
struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms, antonyms: [String]
}

// MARK: - Definition
struct Definition: Codable {
    let definition: String
    let example: String?
}

// MARK: - Phonetic
struct Phonetic: Codable {
    let audio: String
    let sourceURL: String?
    let license: License?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case audio
        case sourceURL = "sourceUrl"
        case license, text
    }
}

