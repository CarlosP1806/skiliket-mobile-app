//
//  HumidityPT.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 15/10/24.
//

import Foundation

// Model for decoding JSON humidity data with decimals
class HumidityPT: Codable {
    let humidity: Double  // Change to Double to support decimals

    enum CodingKeys: String, CodingKey {
        case humidity = "Humidity"
    }

    init(humidity: Double) {  // Change constructor to accept Double
        self.humidity = humidity
    }
}

