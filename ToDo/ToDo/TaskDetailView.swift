//
//  TaskDetailView.swift
//  ToDo
//
//  Created by Heath Johnson on 3/28/25.
//

import SwiftUI
import MapKit

struct TaskDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var showingEditTask = false
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(task.title).font(.largeTitle)
            Text(task.descriptor)
            Text("Due: \(task.dueDate, style: .date)")
            Text("Priority: \(task.priority)")
            
            if let location = task.location {
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))), annotationItems: [location]) { loc in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                .frame(height: 300)
            }
            
            Button("Delete Task") {
                modelContext.delete(task)
                dismiss()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("Task Details")
    }
}
