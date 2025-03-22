//
//  ContentView.swift
//  ToDo
//
//  Created by Heath Johnson on 3/21/25.
//

import SwiftUI
import SwiftData

struct TaskListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var tasks: [Task]
    
    var body: some View {
        NavigationView {
            List(tasks) { task in
                NavigationLink(destination: TaskDetailView(task: task)) {
                    HStack {
                        Text(task.title)
                            .font(.headline)
                        Spacer()
                        if task.isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            .navigationTitle("To-Do List")
            .toolbar {
                Button(action: { /* Add Task Action */ }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    TaskListView()
}
