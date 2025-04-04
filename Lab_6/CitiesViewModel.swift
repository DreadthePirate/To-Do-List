//
//  CitiesViewModel.swift
//  Lab_6
//
//  Created by Heath Johnson on 3/28/25.
//

import SwiftUI
import Foundation

// Define Decodable structs matching the expected JSON response
struct CitiesData: Decodable {
    let geonames: [City]
}

struct City: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let countrycode: String
    let population: Int
    let lat: Double
    let lng: Double
}

class CitiesViewModel: ObservableObject {
    @Published var cities: [City] = []
    
    func fetchCities() {
        let north = "44.1"
        let south = "-9.9"
        let east = "-22.4"
        let west = "55.2"
        let username = "hjohns19"
        
        let urlAsString = "http://api.geonames.org/citiesJSON?north=\(north)&south=\(south)&east=\(east)&west=\(west)&username=\(username)"
        
        guard let url = URL(string: urlAsString) else {
            print("Invalid URL")
            return
        }
        
        let urlSession = URLSession.shared
        let jsonQuery = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")  // Print the response
                }
                
                let decodedData = try JSONDecoder().decode(CitiesData.self, from: data)
                DispatchQueue.main.async {
                    self.cities = Array(decodedData.geonames.prefix(10)) // Limit to 10 cities
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        
        jsonQuery.resume()
    }
}

