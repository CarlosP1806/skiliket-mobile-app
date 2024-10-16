//
//  HumidityData.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 16/10/24.
//

import Foundation
import Combine

class HumidityData: ObservableObject {
<<<<<<< HEAD
    @Published var humidities: [Humidity] = []
    
    func addHumidity(_ humidity: Humidity) {
        humidities.append(humidity)
        if humidities.count > 4 {
            humidities.removeFirst() // Keep only the last 4 humidity readings
        }
    }
}

