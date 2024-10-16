//
//  SoundPT.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 15/10/24.
//

import Foundation


class SoundPT: Codable {
    let sound: Int

    enum CodingKeys: String, CodingKey {
        case sound = "Sound"
    }
    
    init(sound: Int) {
        self.sound = sound
    }
}

