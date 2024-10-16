//
//  NewsArticle.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 05/10/24.
//

import Foundation

// MARK: - IssueReport
class ArticleResponse: Codable {
    let articles: [Article]

    init(articles: [Article]) {
        self.articles = articles
    }
}

// MARK: - Article
class Article: Codable {
    let author: Author
    let bannerName, title, location, date: String
    let preview, content: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case author
        case bannerName = "banner_name"
        case title, location, date, preview, content, comments
    }

    init(author: Author, bannerName: String, title: String, location: String, date: String, preview: String, content: String, comments: [Comment]) {
        self.author = author
        self.bannerName = bannerName
        self.title = title
        self.location = location
        self.date = date
        self.preview = preview
        self.content = content
        self.comments = comments
    }
}

// MARK: - Author
class Author: Codable {
    let name, occupation: String

    init(name: String, occupation: String) {
        self.name = name
        self.occupation = occupation
    }
}

// MARK: - Comment
class Comment: Codable {
    let author, date, content: String

    init(author: String, date: String, content: String) {
        self.author = author
        self.date = date
        self.content = content
    }
}

enum NewsArticleError: Error, LocalizedError {
    case fetchError
}

extension Article {
    static func fetchArticles(url: String) async throws -> [Article] {
        let urlComponents = URLComponents(string: url)!
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NewsArticleError.fetchError
        }
        
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(ArticleResponse.self, from: data)

        return searchResponse.articles
    }
}
