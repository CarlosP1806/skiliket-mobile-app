//
//  SmokePT.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 15/10/24.
//

import Foundation


class SmokePT: Codable {
    let smoke: Int

    enum CodingKeys: String, CodingKey {
        case smoke = "Smoke"
    }
    
    init(smoke: Int) {
        self.smoke = smoke
    }
}

