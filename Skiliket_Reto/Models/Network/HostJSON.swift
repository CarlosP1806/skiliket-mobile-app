//
//  HostJSON.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 11/10/24.
//

import Foundation

// MARK: - Welcome
class Welcome: Codable {
    let response: [Response]
    let version: String

    init(response: [Response], version: String) {
        self.response = response
        self.version = version
    }
}
enum WelcomeError: Error, LocalizedError{
    case HostsNotFound
    case TokenGenerationError
}
// MARK: - Response
class Response: Codable {
    let connectedAPMACAddress, connectedAPName, connectedInterfaceName, connectedNetworkDeviceIPAddress: String
    let connectedNetworkDeviceName, hostIP, hostMAC, hostName: String
    let hostType, id, lastUpdated, pingStatus: String
    let vlanID: String?

    enum CodingKeys: String, CodingKey {
        case connectedAPMACAddress = "connectedAPMacAddress"
        case connectedAPName, connectedInterfaceName
        case connectedNetworkDeviceIPAddress = "connectedNetworkDeviceIpAddress"
        case connectedNetworkDeviceName
        case hostIP = "hostIp"
        case hostMAC = "hostMac"
        case hostName, hostType, id, lastUpdated, pingStatus
        case vlanID = "vlanId"
    }

    init(connectedAPMACAddress: String, connectedAPName: String, connectedInterfaceName: String, connectedNetworkDeviceIPAddress: String, connectedNetworkDeviceName: String, hostIP: String, hostMAC: String, hostName: String, hostType: String, id: String, lastUpdated: String, pingStatus: String, vlanID: String?) {
        self.connectedAPMACAddress = connectedAPMACAddress
        self.connectedAPName = connectedAPName
        self.connectedInterfaceName = connectedInterfaceName
        self.connectedNetworkDeviceIPAddress = connectedNetworkDeviceIPAddress
        self.connectedNetworkDeviceName = connectedNetworkDeviceName
        self.hostIP = hostIP
        self.hostMAC = hostMAC
        self.hostName = hostName
        self.hostType = hostType
        self.id = id
        self.lastUpdated = lastUpdated
        self.pingStatus = pingStatus
        self.vlanID = vlanID
    }
}

extension Welcome{
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
                throw WelcomeError.TokenGenerationError
            }
            let ticketResponse = try? JSONDecoder().decode(TicketResponse.self, from: data)
            retorno = ticketResponse?.response.serviceTicket ?? "TokenError"
            
            return retorno

        } catch {
           print("Error al obtener token: \(error)")
        }
        return retorno
    }
    static func getHosts(token:String) async throws->[Response]{
        let url="http://localhost:58000/api/v1/host"
        let baseURL = URL(string: url)
        var request = URLRequest(url: baseURL!)
        //request.httpMethod = "GET"
        request.addValue(token, forHTTPHeaderField: "X-Auth-Token")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw WelcomeError.HostsNotFound
        }
        let welcomeInstance = try JSONDecoder().decode(Welcome.self, from: data)
        return welcomeInstance.response
        
    }
}
