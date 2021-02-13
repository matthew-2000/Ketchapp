//
//  KetchupModel.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 11/02/21.
//

import Foundation

class KetchupModel: NSObject {
    
    var name: String
    var sessionTime: Int
    var breakTime: Int
    var taskList: [String]
    var date: Date?
    
    init(name: String, sessionTime: Int, breakTime: Int, taskList: [String]) {
        self.name = name
        self.sessionTime = sessionTime
        self.breakTime = breakTime
        self.taskList = taskList
    }
    
    func addTask(task: String) {
        taskList.append(task)
    }
    
    func removeTask(at index: Int) {
        taskList.remove(at: index)
    }
    
    func moveTask(fromIndex: Int, toIndex: Int) {
        let task = taskList.remove(at: fromIndex)
        taskList.insert(task, at: toIndex)
    }
    
    func getTaskCount() -> Int {
        return taskList.count
    }
    
}
