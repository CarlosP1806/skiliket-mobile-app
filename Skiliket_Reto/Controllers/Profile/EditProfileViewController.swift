//
//  EditProfileViewController.swift
//  Skiliket_Reto
//
//  Created by Pedro Luis Pérez Collado on 08/10/24.
//

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var profileImageViewEdit: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var profileContainerView: UIView!
    
    // Variables to hold the profile and the image passed from ProfileViewController
    var profile: Profile?
    var profileImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the profile view to be rounded
        profileContainerView.layer.cornerRadius = 20  // Adjust the radius as needed
        profileContainerView.layer.masksToBounds = true
        
        // Populate the fields with profile data passed from ProfileViewController
        if let profile = profile {
            usernameLabel.text = profile.username
            titleTextField.text = profile.contactInfo.title
            emailTextField.text = profile.contactInfo.email
            phoneTextField.text = profile.contactInfo.phone
            addressTextField.text = profile.contactInfo.address
        }

        // Display the profile image passed from ProfileViewController
        if let image = profileImage {
            profileImageViewEdit.image = image
        } else {
            profileImageViewEdit.image = UIImage(systemName: "person.crop.circle")
        }

        // Set the text fields' delegate to self to handle "Done" button functionality
        titleTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        addressTextField.delegate = self

        // Add tap gesture to dismiss keyboard when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    // Adjust the view position when the keyboard frame changes
    @objc func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.height
            let isKeyboardShowing = keyboardFrame.origin.y < UIScreen.main.bounds.height

            // If the keyboard is showing, move the view up; otherwise, move it back down
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = isKeyboardShowing ? -keyboardHeight / 7 : 0
            }
        }
    }
    
    // Dismiss the keyboard when tapping "Done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Hide the keyboard
        return true
    }

    // Dismiss the keyboard when tapping outside of the text fields
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }


    // Action for when the "Save" button is pressed
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        // Show an alert to simulate data saving
        let alert = UIAlertController(title: "Data Saved", message: "Your changes have been saved succesfully.", preferredStyle: .alert)
        
        // Add an action to the alert that returns to the previous view (ProfileViewController)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // Navigate back to ProfileViewController after saving (simulate data save)
            self.navigationController?.popViewController(animated: true)
        }))
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }
}


