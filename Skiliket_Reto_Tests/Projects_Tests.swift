//
//  Projects_Tests.swift
//  Skiliket_Reto_Tests
//
//  Created by Eashley Brittney Martinez Vergara on 16/10/24.
//

import XCTest
@testable import Skiliket_Reto

var projectListVC: ListProjectsController!
var numberOfProjectsFetched = 5

var firstProjectName = "SKILIKET Environmental Monitoring in Guadalajara"
var firstProjectID = "001"
var firstProjectLocation = "Guadalajara, Mexico"

final class Projects_Tests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        projectListVC = storyboard.instantiateViewController(withIdentifier: "ListProjectsController") as? ListProjectsController
        projectListVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        projectListVC = nil
        try super.tearDownWithError()
    }

    func testFetchProjectSuccess() async throws{
        let expectation = self.expectation(description: "Projects fetched correctly from url")
        do {
            let projects = try await Project.fetchProjects(url: "http://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo4/projects.json")
            
            XCTAssertEqual(projects.count, numberOfProjectsFetched)
            expectation.fulfill()
        } catch {
            XCTFail("Error fetching projects")
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchProjectsFailure() async throws {
        let expectation = self.expectation(description: "Projects fetched incorrectly from url")
        do {
            let articles = try await Project.fetchProjects(url: "http://localhost:9080")
            XCTAssertEqual(articles.count, 0, "The number of fetched projects should have been 0")
            expectation.fulfill()
        } catch {
            XCTAssertNotNil(error, "An error should have been occurred during the fetch")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    func testShowDetailsOfProjectSuccess() async throws {
        let expectation = self.expectation(description: "Projects fetched correctly from url")
        do {
            let projects = try await Project.fetchProjects(url: "http://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo4/projects.json")
            
            let firstProject = projects[0]
            
            XCTAssertEqual(firstProject.title, firstProjectName)
            XCTAssertEqual(firstProject.projectID, firstProjectID)
            XCTAssertEqual(firstProject.location, firstProjectLocation)
            expectation.fulfill()
        } catch {
            XCTFail("Error fetching projects")
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
