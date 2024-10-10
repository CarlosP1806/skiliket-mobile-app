//
//  PrivacyPolicy.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 09/10/24.
//

import Foundation

// MARK: - PrivacyPolicy
class PrivacyPolicy: Codable {
    let privacyPolicy: PrivacyPolicyClass

    init(privacyPolicy: PrivacyPolicyClass) {
        self.privacyPolicy = privacyPolicy
    }
}

// MARK: - PrivacyPolicyClass
class PrivacyPolicyClass: Codable {
    let title, content: String

    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

extension PrivacyPolicy {
    static func fetchProfile() async throws -> PrivacyPolicy {
        let urlComponents = URLComponents(string: "http://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo4/privacypolicy.json")!
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let privacypolicy = try decoder.decode(PrivacyPolicy.self, from: data)
        
        return privacypolicy
    }
}
