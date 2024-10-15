//
//  HumidityPT.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 15/10/24.
//

import Foundation

class HumidityPT: Codable {
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case humidity = "Humidity"
    }
    
    init(humidity: Int) {
        self.humidity = humidity
    }
}

