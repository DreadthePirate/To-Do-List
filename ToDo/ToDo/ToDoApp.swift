//
//  ToDoApp.swift
//  ToDo
//


import SwiftUI
import SwiftData

@main
struct ToDoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Task.self])
        let container = try! ModelContainer(for: schema)
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
                .modelContainer(sharedModelContainer)
        }
    }
}

