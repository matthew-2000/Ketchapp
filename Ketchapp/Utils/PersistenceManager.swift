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
    
    static func saveContext() {
        let context = getContext()
        do {
            try context.save()
        } catch let error as NSError {
            print("Error in saving context: \(error.code)")
        }
    }
    
    static func insertKetchup(ketchup: KetchupModel) {
        
        let context = getContext()
        
        let ketchupToSet = NSEntityDescription.insertNewObject(forEntityName: ketchupName, into: context) as! Ketchup
        
        ketchupToSet.name = ketchup.name
        ketchupToSet.sessionTime = Int16(ketchup.sessionTime)
        ketchupToSet.breakTime = Int16(ketchup.breakTime)
        ketchupToSet.taskList = ketchup.taskList
        ketchupToSet.date = nil
        
        saveContext()
        
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
    
    static func getKetchupList() -> [KetchupModel] {
        let ketchupListPersistent = PersistenceManager.fetchKetchup()
        var ketchupList = [KetchupModel]()
        
        for k in ketchupListPersistent {
            ketchupList.append(KetchupModel(name: k.name!, sessionTime: Int(k.sessionTime), breakTime: Int(k.breakTime), taskList: k.taskList!))
        }
        
        return ketchupList
    }
    
    static func deleteItem(item: KetchupModel) {
        let context = getContext()
        
        let ketchupList = fetchKetchup()
        for ketchup in ketchupList {
            if ketchup.name == item.name {
                context.delete(ketchup)
                break
            }
        }
        
        saveContext()
    }
    
    static func deleteItem(withName name: String?) {
        let context = getContext()
        
        let ketchupList = fetchKetchup()
        for ketchup in ketchupList {
            if ketchup.name == name {
                context.delete(ketchup)
                break
            }
        }
        
        saveContext()
    }
    
    static func findItem(withName name: String?) -> Bool {
        let ketchupList = fetchKetchup()
        for ketchup in ketchupList {
            if ketchup.name == name {
                return true
            }
        }
        return false
    }
    
}
