


import SwiftUI
import MapKit

struct CityMapView: View {
    let city: City
    
    @State private var region: MKCoordinateRegion
    
    init(city: City) {
        self.city = city
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: city.lat, longitude: city.lng),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        ))
    }
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: [city]) { city in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: city.lat, longitude: city.lng)) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.largeTitle)
                        Text(city.name)
                            .font(.caption)
                            .bold()
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle(city.name)
    }
}
