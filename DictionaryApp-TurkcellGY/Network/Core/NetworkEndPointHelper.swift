//
//  NetworkEndPointHelper.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 22.07.2024.
//

import Foundation

struct NetworkEndPointHelper {
    static let shared = NetworkEndPointHelper()
    
    func requestDetailWord(word:String) -> String {
        NetworkConstants.detailURL + word
    }
    
    func requestSynonmysWord(word: String) -> String {
        NetworkConstants.synonmysURL + word
    }
}
