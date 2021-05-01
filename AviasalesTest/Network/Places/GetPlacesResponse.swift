//
//  GetPlacesResponse.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 01.05.2021.
//

import Foundation

struct CityModel: Codable {
    let name: String
    let iata: String?
    let airportName: String?
    let location: Coordinates
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}
