//
//  TaskViewModel.swift
//  ToDo
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

struct Quote: Codable, Identifiable, Hashable {
    var id = UUID()
    var quote: String
    var author: String

    enum CodingKeys: String, CodingKey {
        case quote, author
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quote = try container.decode(String.self, forKey: .quote)
        author = try container.decode(String.self, forKey: .author)
        id = UUID()
    }

    init(quote: String, author: String) {
        self.quote = quote
        self.author = author
    }
}

class QuoteViewModel: ObservableObject {
    @Published var dailyQuote: Quote?
    private var allQuotes: [Quote] = []

    func fetchDailyQuote() async {
        guard let url = URL(string: "https://raw.githubusercontent.com/AtaGowani/daily-motivation/refs/heads/master/src/data/quotes.json") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.allQuotes = try JSONDecoder().decode([Quote].self, from: data)

            DispatchQueue.main.async {
                self.pickRandomQuote()
            }
        } catch {
            print("Error fetching quote: \(error.localizedDescription)")
        }
    }

    func pickRandomQuote() {
        guard !allQuotes.isEmpty else { return }
        dailyQuote = allQuotes.randomElement()
    }
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
