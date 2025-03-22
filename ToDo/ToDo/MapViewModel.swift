//
//  MapViewModel.swift
//  ToDo
//
//  Created by Heath Johnson on 3/21/25.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @Published var tasks: [Task] = []
    
    func fetchTasksWithLocation() {
        // Fetch tasks from SwiftData and filter those with locations
    }
}

struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.tasks) { task in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: task.location?.latitude ?? 0, longitude: task.location?.longitude ?? 0)) {
                Image(systemName: "pin.circle.fill").foregroundColor(.red)
            }
        }
        .onAppear {
            viewModel.fetchTasksWithLocation()
        }
    }
}

