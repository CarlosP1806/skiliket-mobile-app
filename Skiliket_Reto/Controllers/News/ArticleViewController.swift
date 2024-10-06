//
//  ArticleViewController.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 06/10/24.
//

import UIKit

class ArticleViewController: UIViewController {

    var article: Article?
    
    @IBOutlet weak var articleAuthorUsernameLabel: UILabel!
    @IBOutlet weak var articleAuthorOccupationLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleBannerImage: UIImageView!
    @IBOutlet weak var articleContentLabel: UILabel!
    @IBOutlet weak var commentsView: UIView!
    @IBOutlet weak var commentLabel1: UILabel!
    @IBOutlet weak var commentLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleContentLabel.sizeToFit()
        articleTitleLabel.sizeToFit()
        
        articleAuthorUsernameLabel.text = article!.author.name
        articleAuthorOccupationLabel.text = article!.author.occupation
        articleTitleLabel.text = article!.title
        articleContentLabel.text = article!.content
        articleBannerImage.image = UIImage(named: article!.bannerName)
        
        commentsView.layer.cornerRadius = 10.0
        
        commentLabel1.text = article!.comments[0].content
        commentLabel2.text = article!.comments[1].content
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
