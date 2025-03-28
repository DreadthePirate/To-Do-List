//
//  TaskViewModel.swift
//  ToDo
//
//  Created by Heath Johnson on 3/28/25.
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
    
    init(title: String, descriptor: String, dueDate: Date, priority: String, isCompleted: Bool = false, location: TaskLocation? = nil) {
        self.title = title
        self.descriptor = descriptor
        self.dueDate = dueDate
        self.priority = priority
        self.isCompleted = isCompleted
        self.location = location
    }
}

struct TaskLocation: Codable, Identifiable {
    var id: String = UUID().uuidString
    var latitude: Double
    var longitude: Double
}

// ViewModel
class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchTasks()
    }
    
    func fetchTasks() {
        let fetchDescriptor = FetchDescriptor<Task>()
        do {
            self.tasks = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Error fetching tasks: \(error.localizedDescription)")
        }
    }
    
    func addTask(title: String, descriptor: String, dueDate: Date, priority: String, location: TaskLocation?) {
        let newTask = Task(title: title, descriptor: descriptor, dueDate: dueDate, priority: priority, isCompleted: false, location: location)
        modelContext.insert(newTask)
        fetchTasks()
    }
}
