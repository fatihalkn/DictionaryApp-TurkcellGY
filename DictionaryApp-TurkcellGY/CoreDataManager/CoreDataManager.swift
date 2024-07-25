//
//  CoreDataManager.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 25.07.2024.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveWord(searchWord: String) {
        let request: NSFetchRequest<Word> = Word.fetchRequest()
        request.predicate = NSPredicate(format: "searchWord == %@", "\(searchWord)")
        
        if let existWord = try? context.fetch(request).first {
            return
        }
        
        let words = Word(context: context)
        words.searchWord = searchWord
        
        do {
            try self.context.save()
            print("KELİME BAŞARIYLA KAYDEDİLDİ")
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    func fetchWord() -> [Word]? {
        do {
            let fetchWord = try self.context.fetch(Word.fetchRequest())
            return fetchWord
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        return nil
    }
}
