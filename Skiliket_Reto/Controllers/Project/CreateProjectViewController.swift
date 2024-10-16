//
//  CreateProjectViewController.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 07/10/24.
//

import UIKit

class CreateProjectViewController: UIViewController {
    @IBOutlet weak var createNewProject: UIView!
    
    @IBOutlet weak var createProject: UIButton!
    @IBOutlet weak var uploadImage: UIImageView!
    override func viewDidLoad() {
        createNewProject.layer.cornerRadius = 20
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showImagePickerDialog))
                uploadImage.isUserInteractionEnabled = true
                uploadImage.addGestureRecognizer(tapGesture)
        createProject.addTarget(self, action: #selector(createProjectTapped), for: .touchUpInside)

        createProject.layer.cornerRadius = 10
        createProject.layer.masksToBounds = true
    }
    @objc func showImagePickerDialog() {
        let alertController = UIAlertController(title: "Selecciona una opción", message: nil, preferredStyle: .actionSheet)

        // Opción para tomar una foto
        let cameraAction = UIAlertAction(title: "Tomar foto", style: .default) { _ in
            // Aquí no hacemos nada
        }

        // Opción para elegir de la galería
        let galleryAction = UIAlertAction(title: "Elegir de la galería", style: .default) { _ in
            // Aquí tampoco hacemos nada
        }

        // Opción de cancelar
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        // Agregar las acciones al alertController
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)

        // Presentar el diálogo
        present(alertController, animated: true, completion: nil)
    }
    @objc func createProjectTapped() {
           // Mostrar una alerta indicando que el proyecto se creó con éxito
           let successAlert = UIAlertController(title: "Success", message: "The project was created successfully", preferredStyle: .alert)
           
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           successAlert.addAction(okAction)
           
           // Presentar la alerta
           present(successAlert, animated: true, completion: nil)
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
