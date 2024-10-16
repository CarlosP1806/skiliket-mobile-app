//
//  SmokePT.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 15/10/24.
//

import Foundation

// Model for decoding JSON smoke data with decimals
class SmokePT: Codable {
    let smoke: Double  // Use Double to support decimals

    enum CodingKeys: String, CodingKey {
        case smoke = "Smoke"  // Map the JSON key "Smoke" to the property "smoke"
    }

    init(smoke: Double) {  // Constructor to accept Double
        self.smoke = smoke
    }
}


