//
//  DataManager.swift
//  Werdd
//
//  Created by Moe Steinmueller on 22.04.22.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    static let managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - CREEATE
    static func createFavWord(word: String, definition: String?, partOfSpeech: String?, synonyms: [String]?, antonyms: [String]?, examples: [String]?, id: UUID) {
        
        let favWord = FavWord(context: managedObjectContext)
        favWord.setValue(word, forKey: "word")
        favWord.setValue(definition, forKey: "definition")
        favWord.setValue(partOfSpeech, forKey: "partOfSpeech")
        favWord.setValue(synonyms, forKey: "synonyms")
        favWord.setValue(antonyms, forKey: "antonyms")
        favWord.setValue(examples, forKey: "examples")
        favWord.setValue(id, forKey: "uuid")
        
        do {
            try managedObjectContext.save()
            
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - READ
    static func fetchFavWords(completion: ([FavWord]?) -> Void) {
        do {
            let favWords = try managedObjectContext.fetch(FavWord.createFetchRequest())
            completion(favWords)
        } catch {
            print("Fetch FavWords failed")
        }
        
        completion(nil)
    }
    
    static func fetchFavWord(usingId id: UUID, completion: (FavWord?) -> Void) {
        let fetchRequest = NSFetchRequest<FavWord>(entityName: "FavWord")
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", id as CVarArg)
        
        do {
            let favWord = try managedObjectContext.fetch(fetchRequest)
            completion(favWord.first)
        } catch {
            print("Could not fetch due to error: \(error.localizedDescription)")
        }
        
        completion(nil)
    }
    
    static func fetchFavWord(usingWord word: String, definition: String?, completion: (FavWord?) -> Void) {
        let fetchRequest = NSFetchRequest<FavWord>(entityName: "FavWord")
        fetchRequest.predicate = NSPredicate(format: "word == %@", word as CVarArg)
        
        do {
            let favWord = try managedObjectContext.fetch(fetchRequest)
            completion(favWord.first)
        } catch {
            print("Could not fetch due to error: \(error.localizedDescription)")
        }
        
        completion(nil)
    }
    
    
    // MARK: - UPDATE?
    static func updateFavWord() {
        
    }
    
    // MARK: - DELETE
    static func deleteFavWord(usingID id: UUID) {
        let fetchRequest: NSFetchRequest<FavWord> = FavWord.createFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", id as CVarArg)
        
        if let result = try? managedObjectContext.fetch(fetchRequest) {
            for object in result {
                managedObjectContext.delete(object)
            }
        }
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
}
