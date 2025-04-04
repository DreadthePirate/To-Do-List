

import SwiftUI

struct CitiesListView: View {
    @StateObject var viewModel = CitiesViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.cities) { city in
                NavigationLink(destination: CityMapView(city: city)) {
                    VStack(alignment: .leading) {
                        Text(city.name)
                            .font(.headline)
                        Text("\(city.countrycode) - Population: \(city.population)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Cities")
            .onAppear {
                viewModel.fetchCities()
            }
        }
    }
}
