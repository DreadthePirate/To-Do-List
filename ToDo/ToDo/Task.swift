//
//  Task.swift
//  ToDo
//
//  Created by Heath Johnson on 3/21/25.
//

import SwiftUI
import SwiftData

@Model
class Task {
    var id: String = UUID().uuidString
    var title: String
    var descriptor: String
    var dueDate: Date
    var priority: String
    var isCompleted: Bool
    var location: TaskLocation?
    
    init(title: String, description: String, dueDate: Date, priority: String, isCompleted: Bool = false, location: TaskLocation? = nil) {
        self.title = title
        self.descriptor = description
        self.dueDate = dueDate
        self.priority = priority
        self.isCompleted = isCompleted
        self.location = location
    }
}
struct TaskLocation: Codable {
    var latitude: Double
    var longitude: Double
}

