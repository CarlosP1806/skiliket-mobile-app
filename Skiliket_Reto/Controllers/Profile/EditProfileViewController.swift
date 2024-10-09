//
//  EditProfileViewController.swift
//  Skiliket_Reto
//
//  Created by Pedro Luis Pérez Collado on 08/10/24.
//

import UIKit

class EditProfileViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var profileImageViewEdit: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!

    // Variables to hold the profile and the image passed from ProfileViewController
    var profile: Profile?
    var profileImage: UIImage?  // To receive the passed image

    override func viewDidLoad() {
        super.viewDidLoad()

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
            profileImageViewEdit.image = UIImage(systemName: "person.crop.circle")  // Fallback image
        }
    }

    // Action for when the "Save" button is pressed
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Show an alert to simulate data saving
        let alert = UIAlertController(title: "Datos Guardados", message: "Los cambios han sido guardados exitosamente.", preferredStyle: .alert)
        
        // Add an action to the alert that returns to the previous view (ProfileViewController)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // Navigate back to ProfileViewController after saving (simulate data save)
            self.navigationController?.popViewController(animated: true)
        }))
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }
}


