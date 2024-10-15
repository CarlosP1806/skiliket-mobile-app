//
//  Temperature.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 14/10/24.
//

import Foundation

class Temperature: Identifiable{ //para el uso de este tipo de datos en Charts se requiere que cumpla con el protocolo Identifiable
    var value:String
    var timeStamp:Date
    init(value: String, timeStamp: Date) {
        self.value = value
        self.timeStamp = timeStamp
    }
}

