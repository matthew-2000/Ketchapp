//
//  PersistenceManager.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 11/02/21.
//

import Foundation
import CoreData
import UIKit

class PersistenceManager {
    
    static let ketchupName = "Ketchup"
    
    static func getContext() -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    static func insertKetchup(ketchup: KetchupModel) {
        
        let context = getContext()
        
        let ketchupToSet = NSEntityDescription.insertNewObject(forEntityName: ketchupName, into: context) as! Ketchup
        
        ketchupToSet.name = ketchup.name
        ketchupToSet.sessionTime = Int16(ketchup.sessionTime)
        ketchupToSet.breakTime = Int16(ketchup.breakTime)
        ketchupToSet.taskList = [String]()
        ketchupToSet.date = nil
        
    }
    
    static func fetchKetchup() -> [Ketchup] {
        
        var ketchupList = [Ketchup]()
        let context = getContext()
        
        let fetchRequest = NSFetchRequest<Ketchup>(entityName: ketchupName)
        
        do {
            
            try ketchupList = context.fetch(fetchRequest)
            
        } catch let error as NSError {
            
            print("error while fetching ketchups with error: \(error.code)")
            
        }
        
        return ketchupList
        
    }
    
}
