//
//  SmokeData.swift
//  Skiliket_Reto
//
//  Created by Pedro Luis Pérez Collado on 16/10/24.
//

import Foundation
import Combine

class SmokeData: ObservableObject {
    @Published var smokes: [Smoke] = []
    
    func addSmoke(_ smoke: Smoke) {
        smokes.append(smoke)
        if smokes.count > 4 {
            smokes.removeFirst() // Keep only the last 4 smoke readings
        }
    }
}

