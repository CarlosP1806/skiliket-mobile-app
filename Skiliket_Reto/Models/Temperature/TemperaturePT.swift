//
//  TemperaturePT.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 14/10/24.
//

import Foundation

// MARK: - TemperaturePT
class TemperaturePT: Codable {
    let temperature: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "Temperature"
    }
    
    init(temperature: Int) {
        self.temperature = temperature
    }
}


