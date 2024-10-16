//
//  DeviceJSON.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 14/10/24.
//

import Foundation


// MARK: - DeviceData
class DeviceData: Codable {
    let respuesta: [Respuesta]
    let version: String

    enum CodingKeys: String, CodingKey {
        case respuesta = "response"
        case version
    }

    init(respuesta: [Respuesta], version: String) {
        self.respuesta = respuesta
        self.version = version
    }
}
enum DeviceDataError: Error, LocalizedError{
    case DeviceNotFound
    case TokenGenerationError
}

// MARK: - Response
class Respuesta: Codable {
    let collectionStatus: String
    let connectedInterfaceName, connectedNetworkDeviceIPAddress, connectedNetworkDeviceName: [String]
    let errorDescription, globalCredentialID, hostname, id: String
    let interfaceCount, inventoryStatusDetail: String
    let ipAddresses: [String]?
    let lastUpdateTime, lastUpdated, macAddress, managementIPAddress: String
    let platformID, productID, reachabilityFailureReason, reachabilityStatus: String
    let serialNumber, softwareVersion, type, upTime: String

    enum CodingKeys: String, CodingKey {
        case collectionStatus, connectedInterfaceName
        case connectedNetworkDeviceIPAddress = "connectedNetworkDeviceIpAddress"
        case connectedNetworkDeviceName, errorDescription
        case globalCredentialID = "globalCredentialId"
        case hostname, id, interfaceCount, inventoryStatusDetail, ipAddresses, lastUpdateTime, lastUpdated, macAddress
        case managementIPAddress = "managementIpAddress"
        case platformID = "platformId"
        case productID = "productId"
        case reachabilityFailureReason, reachabilityStatus, serialNumber, softwareVersion, type, upTime
    }

    init(collectionStatus: String, connectedInterfaceName: [String], connectedNetworkDeviceIPAddress: [String], connectedNetworkDeviceName: [String], errorDescription: String, globalCredentialID: String, hostname: String, id: String, interfaceCount: String, inventoryStatusDetail: String, ipAddresses: [String]?, lastUpdateTime: String, lastUpdated: String, macAddress: String, managementIPAddress: String, platformID: String, productID: String, reachabilityFailureReason: String, reachabilityStatus: String, serialNumber: String, softwareVersion: String, type: String, upTime: String) {
        self.collectionStatus = collectionStatus
        self.connectedInterfaceName = connectedInterfaceName
        self.connectedNetworkDeviceIPAddress = connectedNetworkDeviceIPAddress
        self.connectedNetworkDeviceName = connectedNetworkDeviceName
        self.errorDescription = errorDescription
        self.globalCredentialID = globalCredentialID
        self.hostname = hostname
        self.id = id
        self.interfaceCount = interfaceCount
        self.inventoryStatusDetail = inventoryStatusDetail
        self.ipAddresses = ipAddresses
        self.lastUpdateTime = lastUpdateTime
        self.lastUpdated = lastUpdated
        self.macAddress = macAddress
        self.managementIPAddress = managementIPAddress
        self.platformID = platformID
        self.productID = productID
        self.reachabilityFailureReason = reachabilityFailureReason
        self.reachabilityStatus = reachabilityStatus
        self.serialNumber = serialNumber
        self.softwareVersion = softwareVersion
        self.type = type
        self.upTime = upTime
    }
}
extension DeviceData{
    static func getToken() async throws->String?{
        let url="http://localhost:58000/api/v1/ticket"
        var retorno="TokenError"
        let baseURL = URL(string: url)
        var request = URLRequest(url: baseURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //Agregar las cabeceras HTTP necesarias
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parametros: [String: String] = [
            "username": "cisco",
            "password": "cisco123!"
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parametros, options: [])

            //Configurar el cuerpo del request con el JSON
            request.httpBody = jsonData

            // Hacer la solicitud usando URLSession
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                throw DeviceDataError.TokenGenerationError
            }
            let ticketResponse = try? JSONDecoder().decode(TicketResponse.self, from: data)
            retorno = ticketResponse?.response.serviceTicket ?? "TokenError"
            
            return retorno

        } catch {
           print("Error al obtener token: \(error)")
        }
        return retorno
    }
    static func getDevices(token:String) async throws->[Respuesta]{
        let url="http://localhost:58000/api/v1/network-device"
        let baseURL = URL(string: url)
        var request = URLRequest(url: baseURL!)
        //request.httpMethod = "GET"
        request.addValue(token, forHTTPHeaderField: "X-Auth-Token")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DeviceDataError.DeviceNotFound
        }
        let deviceDataInstance = try JSONDecoder().decode(DeviceData.self, from: data)
        return deviceDataInstance.respuesta
        
    }
}
