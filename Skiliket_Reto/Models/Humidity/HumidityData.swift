//
//  HumidityData.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 16/10/24.
//


import Foundation
import Combine

class HumidityData: ObservableObject {
    @Published var humidity_: [Humidity] = []
    
    func addHumidity(_ humidity: Humidity) {
        humidity_.append(humidity)
        if humidity_.count > 4 {
            humidity_.removeFirst() // Keep only the last 4 temperatures
        }
    }
}
