//
//  SignupViewController.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 16/10/24.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var loginNavButton: UIButton!
    @IBOutlet weak var signupNavButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            loginNavButton.layer.cornerRadius = 10
            signupNavButton.layer.cornerRadius = 10
            signUp.layer.cornerRadius = 10
            signUp.isEnabled = false // Deshabilitar el botón inicialmente
            
            passwordTextField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
            setupKeyboardHiding()
            
            cardView.layer.cornerRadius = 40
        }
        
        @objc func passwordTextFieldChanged(_ textField: UITextField) {
            guard let password = textField.text else { return }
            
            // Verifica si la longitud de la contraseña es válida
            signUp.isEnabled = password.count >= 8 && password.count <= 12
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
