//
//  Word+CoreDataProperties.swift
//  DictionaryApp-TurkcellGY
//
//  Created by Fatih on 25.07.2024.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var searchWord: String?

}

extension Word : Identifiable {

}
