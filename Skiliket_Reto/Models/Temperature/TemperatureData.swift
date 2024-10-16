//
//  TemperatureData.swift
//  Skiliket_Reto
//
//  Created by Pedro Luis Pérez Collado on 16/10/24.
//

import Foundation
import Combine

class TemperatureData: ObservableObject {
    @Published var temperatures: [Temperature] = []
    
    func addTemperature(_ temperature: Temperature) {
        temperatures.append(temperature)
        if temperatures.count > 4 {
            temperatures.removeFirst() // Keep only the last 4 temperatures
        }
    }
}
