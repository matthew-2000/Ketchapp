//
//  Ketchup+CoreDataProperties.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 11/02/21.
//
//

import Foundation
import CoreData


extension Ketchup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ketchup> {
        return NSFetchRequest<Ketchup>(entityName: "Ketchup")
    }

    @NSManaged public var breakTime: Int16
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var sessionTime: Int16
    @NSManaged public var taskList: [String]?

}

extension Ketchup : Identifiable {

}
