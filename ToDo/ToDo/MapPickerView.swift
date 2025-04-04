//
//  MapPickerView.swift
//  ToDo
//

import SwiftUI
import MapKit


struct MapPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedLocation: CLLocationCoordinate2D?
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State private var searchQuery: String = ""
    @State private var searchResults: [MKMapItem] = []
    
    var body: some View {
        VStack {
            TextField("Search for an address", text: $searchQuery, onCommit: performSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List(searchResults, id: \.self) { result in
                Button(action: {
                    if let coordinate = result.placemark.location?.coordinate {
                        selectedLocation = coordinate
                        region.center = coordinate
                    }
                }) {
                    Text(result.placemark.title ?? "Unknown Address")
                }
            }
            
            Map(coordinateRegion: $region, interactionModes: .all, annotationItems: selectedLocation.map { [TaskLocation(latitude: $0.latitude, longitude: $0.longitude)] } ?? []) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                }
            }
            .gesture(DragGesture().onEnded { _ in
                selectedLocation = region.center
            })
            
            Button("Confirm Location") {
                selectedLocation = region.center
                dismiss()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Close") {
                dismiss()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
    private func performSearch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let response = response {
                searchResults = response.mapItems
            }
        }
    }
}
