//
//  AddTaskView.swift
//  ToDo
//

import SwiftUI
import MapKit

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var title: String = ""
    @State private var descriptor: String = ""
    @State private var dueDate: Date = Date()
    @State private var priority: String = "Medium"
    @State private var selectedLocation: CLLocationCoordinate2D? = nil
    @State private var showingMapPicker = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $descriptor)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                Picker("Priority", selection: $priority) {
                    Text("Low").tag("Low")
                    Text("Medium").tag("Medium")
                    Text("High").tag("High")
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Button("Select Location") {
                    showingMapPicker = true
                }
                
                if let location = selectedLocation {
                    Text("Selected Location: \(location.latitude), \(location.longitude)")
                }
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let taskLocation = selectedLocation.map { TaskLocation(latitude: $0.latitude, longitude: $0.longitude) }
                        let newTask = Task(title: title, descriptor: descriptor, dueDate: dueDate, priority: priority, isCompleted: false, location: taskLocation)
                        modelContext.insert(newTask)
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingMapPicker) {
                MapPickerView(selectedLocation: $selectedLocation)
            }
        }
    }
}
