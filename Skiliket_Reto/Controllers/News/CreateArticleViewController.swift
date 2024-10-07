//
//  CreateArticleViewController.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 06/10/24.
//

import UIKit

class CreateArticleViewController: UIViewController {
    
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(tapGesture)
        setupKeyboardHiding()
        
        titleView.layer.cornerRadius = 10.0
        locationView.layer.cornerRadius = 10.0
        bannerView.layer.cornerRadius = 10.0
        contentView.layer.cornerRadius = 10.0
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! NewsFeedViewController
        nextView.showPublishSuccessToast = true
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

}
