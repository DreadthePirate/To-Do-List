//
//  TaskViewModel.swift
//  ToDo
//
//  Created by Heath Johnson on 3/21/25.
//

import SwiftUI
import SwiftData


class TaskViewModel: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    @Published var tasks: [Task] = []
    
    init() {
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
    
    func addTask(title: String, description: String, dueDate: Date, priority: String, location: TaskLocation?) {
        let newTask = Task(title: title, description: description, dueDate: dueDate, priority: priority, isCompleted: false, location: location)
        modelContext.insert(newTask)
        fetchTasks()
    }
}
