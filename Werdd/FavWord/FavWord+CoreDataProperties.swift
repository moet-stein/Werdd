//
//  FavWord+CoreDataProperties.swift
//  Werdd
//
//  Created by Moe Steinmueller on 22.04.22.
//
//

import Foundation
import CoreData


extension FavWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavWord> {
        return NSFetchRequest<FavWord>(entityName: "FavWord")
    }

    @NSManaged public var word: String
    @NSManaged public var partOfSpeech: String?
    @NSManaged public var synonyms: [String]?
    @NSManaged public var antonyms: [String]?
    @NSManaged public var examples: [String]?
    @NSManaged public var definition: String?

}

extension FavWord : Identifiable {

}
