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
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var articleLocationLabel: UILabel!
    @IBOutlet weak var articleDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleContentLabel.sizeToFit()
        articleTitleLabel.sizeToFit()
        
        articleAuthorUsernameLabel.text = article!.author.name
        articleAuthorOccupationLabel.text = article!.author.occupation
        articleTitleLabel.text = article!.title
        articleContentLabel.text = article!.content
        articleBannerImage.image = UIImage(named: article!.bannerName)
        articleLocationLabel.text = article!.location
        articleDateLabel.text = "Posted on \(article!.date)"
        
        commentsView.layer.cornerRadius = 10.0
        
        commentLabel1.text = article!.comments[0].content
        commentLabel2.text = article!.comments[1].content
        
        commentLabel1.sizeToFit()
        commentLabel2.sizeToFit()
        
        shareButton.imageView?.contentMode = .scaleAspectFit
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(tapGesture)
        setupKeyboardHiding()

    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
                      let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                      let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
                let newFrameY = (textBoxY - keyboardTopY / 2) * -1
                view.frame.origin.y = newFrameY
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    @objc func hideKeyboard() {
           view.endEditing(true) // Dismisses the keyboard
    }
    

    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
