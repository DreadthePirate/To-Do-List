//
//  TaskListView.swift
//  ToDo
//


import SwiftUI
import SwiftData
import MapKit

struct TaskListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var tasks: [Task]
    @State private var showingAddTask = false
    @StateObject private var quoteViewModel = QuoteViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if let quote = quoteViewModel.dailyQuote {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\"\(quote.quote)\"")
                            .italic()
                            .font(.title3)
                        Text("— \(quote.author)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Button("New Quote") {
                            quoteViewModel.pickRandomQuote()
                        }
                        .font(.caption)
                        .padding(.top, 4)
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                    .padding([.top, .horizontal])
                }

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
            }
            .navigationTitle("To-Do List")
            .toolbar {
                Button(action: { showingAddTask = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView()
            }
            .task {
                await quoteViewModel.fetchDailyQuote()
            }
        }
    }
}

#Preview {
    TaskListView()
}
