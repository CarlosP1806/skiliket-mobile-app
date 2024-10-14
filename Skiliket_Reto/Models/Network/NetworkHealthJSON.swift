//
//  NetworkHealthJSON.swift
//  Skiliket_Reto
//
//  Created by Pedro Luis Pérez Collado on 13/10/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let networkHealth = try? JSONDecoder().decode(NetworkHealth.self, from: jsonData)

import Foundation

// MARK: - NetworkHealth
class NetworkHealth: Codable {
    let response: [NetworkHealthResponse]
    let version: String

    init(response: [NetworkHealthResponse], version: String) {
        self.response = response
        self.version = version
    }
}
// MARK: - NetworkHealthError Enum
enum NetworkHealthError: Error, LocalizedError {
    case NetHealthNotFound
    case TokenGenerationError

    var errorDescription: String? {
        switch self {
        case .NetHealthNotFound:
            return "Network health not found."
        case .TokenGenerationError:
            return "Token generation failed."
        }
    }
}

// MARK: - Response
class NetworkHealthResponse: Codable {
    let clients: Clients
    let networkDevices: NetworkDevices
    let timestamp: String

    init(clients: Clients, networkDevices: NetworkDevices, timestamp: String) {
        self.clients = clients
        self.networkDevices = networkDevices
        self.timestamp = timestamp
    }
    // Computed property to convert timestamp string to Date
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: timestamp)
    }
}

// MARK: - Clients
class Clients: Codable {
    let totalConnected, totalPercentage: String

    init(totalConnected: String, totalPercentage: String) {
        self.totalConnected = totalConnected
        self.totalPercentage = totalPercentage
    }
}

// MARK: - NetworkDevices
class NetworkDevices: Codable {
    let networkDevices: [NetworkDevice]
    let totalDevices, totalPercentage: String

    init(networkDevices: [NetworkDevice], totalDevices: String, totalPercentage: String) {
        self.networkDevices = networkDevices
        self.totalDevices = totalDevices
        self.totalPercentage = totalPercentage
    }
}

// MARK: - NetworkDevice
class NetworkDevice: Codable {
    let deviceType: DeviceType
    let healthyPercentage: String
    let healthyRatio: String

    init(deviceType: DeviceType, healthyPercentage: String, healthyRatio: String) {
        self.deviceType = deviceType
        self.healthyPercentage = healthyPercentage
        self.healthyRatio = healthyRatio
    }
}

enum DeviceType: String, Codable {
    case routers = "Routers"
    case switches = "Switches"
}

extension NetworkHealth {
    static func getToken() async throws -> String? {
        let url = "http://localhost:58000/api/v1/ticket"
        var retorno = "TokenError"
        guard let baseURL = URL(string: url) else { return retorno }
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parametros: [String: String] = [
            "username": "cisco",
            "password": "cisco123!"
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parametros, options: [])
            request.httpBody = jsonData

            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                throw NetworkHealthError.TokenGenerationError
            }

            let ticketResponse = try? JSONDecoder().decode(TicketResponse.self, from: data)
            retorno = ticketResponse?.response.serviceTicket ?? "TokenError"

            return retorno
        } catch {
            print("Error al obtener token: \(error)")
        }
        return retorno
    }

    static func getNetworkHealth(token: String) async throws -> [NetworkHealthResponse] {
        let url = "http://localhost:58000/api/v1/assurance/health"
        guard let baseURL = URL(string: url) else { throw NetworkHealthError.NetHealthNotFound }
        var request = URLRequest(url: baseURL)
        request.addValue(token, forHTTPHeaderField: "X-Auth-Token")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkHealthError.NetHealthNotFound
        }

        let networkHealthInstance = try JSONDecoder().decode(NetworkHealth.self, from: data)
        return networkHealthInstance.response
    }
}
