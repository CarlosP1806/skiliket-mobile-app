//
//  News_Tests.swift
//  Skiliket_Reto_Tests
//
//  Created by Carlos Alberto Paez De la Cruz on 15/10/24.
//

import XCTest
@testable import Skiliket_Reto

var newsFeedVC: NewsFeedViewController!
var numberOfNewsFetched = 4

var firstArticleAuthor = "John Doe"
var firstArticleDate = "2020-09-01"
var firstArticleTitle = "Increment of wildfires in California"

final class News_Tests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        newsFeedVC = storyboard.instantiateViewController(withIdentifier: "NewsFeedViewController") as? NewsFeedViewController
        newsFeedVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        newsFeedVC = nil
        try super.tearDownWithError()
    }

    func testFetchNewsArticlesSuccess() async throws{
        let expectation = self.expectation(description: "Articles fetched correctly from url")
        do {
            let articles = try await Article.fetchArticles(url: "http://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo4/news.json")
            
            XCTAssertEqual(articles.count, numberOfNewsFetched)
            expectation.fulfill()
        } catch {
            XCTFail("Error fetching articles")
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchNewsArticlesFailure() async throws {
        let expectation = self.expectation(description: "Articles fetched incorrectly from url")
        do {
            let articles = try await Article.fetchArticles(url: "http://localhost:8080")
            XCTAssertEqual(articles.count, 0, "The number of fetched articles should have been 0")
            expectation.fulfill()
        } catch {
            XCTAssertNotNil(error, "An error should have been occurred during the fetch")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testShowDetailsOfArticleSuccess() async throws {
        let expectation = self.expectation(description: "Articles fetched correctly from url")
        do {
            let articles = try await Article.fetchArticles(url: "http://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo4/news.json")
            
            let firstArticle = articles[0]
            
            XCTAssertEqual(firstArticle.author.name, firstArticleAuthor)
            XCTAssertEqual(firstArticle.date, firstArticleDate)
            XCTAssertEqual(firstArticle.title, firstArticleTitle)
            expectation.fulfill()
        } catch {
            XCTFail("Error fetching articles")
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testShowDetailsOfArticleFailure() async throws {
        let expectation = self.expectation(description: "Articles fetched correctly from url")
        do {
            let articles = try await Article.fetchArticles(url: "http://martinmolina.com.mx/martinmolina.com.mx/reto_skiliket/Equipo4/news_empty.json")
            
            XCTAssertEqual(articles.count, 0)
            expectation.fulfill()
        } catch {
            XCTFail("Error fetching articles")
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
