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
    static func createFavWord() {
        
    }
    // MARK: - READ
    static func fetchFavWords() {
    
    }
    
    static func fetchFavWord() {
        
    }
    
    
    // MARK: - UPDATE?
    static func updateFavWord() {
        
    }
    
    // MARK: - DELETE
    static func deleteFavWord() {
        
    }
    
    
    
    
}
