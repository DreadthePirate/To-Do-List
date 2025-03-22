//
//  TaskDetailView.swift
//  ToDo
//
//  Created by Heath Johnson on 3/21/25.
//

import SwiftUI

struct TaskDetailView: View {
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(task.title).font(.largeTitle)
            Text(task.descriptor)
            Text("Due: \(task.dueDate, style: .date)")
            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
    }
}
