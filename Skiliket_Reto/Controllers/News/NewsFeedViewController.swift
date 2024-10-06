//
//  NewsFeedViewController.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 05/10/24.
//

import UIKit

class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTableView: UITableView!
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                self.articles = try await Article.fetchArticles()
                newsTableView.reloadData()
                print(articles)
            }
            catch {
                print("Error: \(error)")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        let currentArticle = articles[indexPath.row]
        
        cell.configure(title: currentArticle.title, description: currentArticle.preview, imageUrl: currentArticle.bannerName)
        
        return cell
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! ArticleViewController
        let index = newsTableView.indexPathForSelectedRow?.row
        guard let index = index else {
            return
        }
        let article = articles[index]
        nextView.article = article
    }
    

}

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var articleView: UIView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    func configure(title: String, description: String, imageUrl: String) {
        articleTitleLabel.text = title
        articleDescriptionLabel.text = description
        articleImageView.image = UIImage(named: imageUrl)
        
        articleView.layer.cornerRadius = 20
        articleView.layer.masksToBounds = true
    }
}
