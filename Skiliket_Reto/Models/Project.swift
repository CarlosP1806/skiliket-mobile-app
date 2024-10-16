//
//  Project.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 06/10/24.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let projectData = try? JSONDecoder().decode(ProjectData.self, from: jsonData)

import Foundation

// MARK: - ProjectData
class ProjectData: Codable {
    let projects: [Project]

    init(projects: [Project]) {
        self.projects = projects
    }
}

// MARK: - Project
class Project: Codable {
    let projectID, title, projectBanner, startDate: String
    let status, location: String
    let participants, reports: Int
    let sensors: Sensors
    let details: Details

    enum CodingKeys: String, CodingKey {
        case projectID = "project_id"
        case title
        case projectBanner = "project_banner"
        case startDate = "start_date"
        case status, location, participants, reports, sensors, details
    }

    init(projectID: String, title: String, projectBanner: String, startDate: String, status: String, location: String, participants: Int, reports: Int, sensors: Sensors, details: Details) {
        self.projectID = projectID
        self.title = title
        self.projectBanner = projectBanner
        self.startDate = startDate
        self.status = status
        self.location = location
        self.participants = participants
        self.reports = reports
        self.sensors = sensors
        self.details = details
    }
}

// MARK: - Details
class Details: Codable {
    let description, teamLead, funding: String
    let relatedArticles: [String]

    enum CodingKeys: String, CodingKey {
        case description
        case teamLead = "team_lead"
        case funding
        case relatedArticles = "related_articles"
    }

    init(description: String, teamLead: String, funding: String, relatedArticles: [String]) {
        self.description = description
        self.teamLead = teamLead
        self.funding = funding
        self.relatedArticles = relatedArticles
    }
}

// MARK: - Sensors
class Sensors: Codable {
    let active: [String]

    init(active: [String]) {
        self.active = active
    }
}

extension Project {
    static func fetchProjects(url: String) async throws -> [Project] {
        let urlComponents = URLComponents(string: url)!
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let newResponse = try decoder.decode(ProjectData.self, from: data)

        return newResponse.projects
    }
}
