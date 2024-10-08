//
//  Profile.swift
//  Skiliket_Reto
//
//  Created by Pedro Luis Pérez Collado on 07/10/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profile = try? JSONDecoder().decode(Profile.self, from: jsonData)

import Foundation

// MARK: - Profile
class Profile: Codable {
    let profile: ProfileClass

    init(profile: ProfileClass) {
        self.profile = profile
    }
}

// MARK: - ProfileClass
class ProfileClass: Codable {
    let username, userID: String
    let contactInfo: ContactInfo
    let stats: Stats

    enum CodingKeys: String, CodingKey {
        case username
        case userID = "user_id"
        case contactInfo = "contact_info"
        case stats
    }

    init(username: String, userID: String, contactInfo: ContactInfo, stats: Stats) {
        self.username = username
        self.userID = userID
        self.contactInfo = contactInfo
        self.stats = stats
    }
}

// MARK: - ContactInfo
class ContactInfo: Codable {
    let title, email, phone, address: String

    init(title: String, email: String, phone: String, address: String) {
        self.title = title
        self.email = email
        self.phone = phone
        self.address = address
    }
}

// MARK: - Stats
class Stats: Codable {
    let enrolledProjects, publishedNews: Int

    enum CodingKeys: String, CodingKey {
        case enrolledProjects = "enrolled_projects"
        case publishedNews = "published_news"
    }

    init(enrolledProjects: Int, publishedNews: Int) {
        self.enrolledProjects = enrolledProjects
        self.publishedNews = publishedNews
    }
}

extension ProfileClass {
    static func fetchProfile() async throws -> ProfileClass {
        let urlComponents = URLComponents(string: "http://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo4/profile.json")!
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let profileData = try decoder.decode(ProfileClass.self, from: data)
        
        return profileData
    }
}
