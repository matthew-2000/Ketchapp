//
//  UserDefaultsManager.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 15/02/21.
//

import Foundation

class UserDefaultsManager {
    
    static func getUserDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
    
    static func getDefaultSessionTime() -> Int {
        return UserDefaults.standard.integer(forKey: "sessionTime")
    }
    
    static func getDefaultBreakTime() -> Int {
        return UserDefaults.standard.integer(forKey: "breakTime")
    }
    
}
