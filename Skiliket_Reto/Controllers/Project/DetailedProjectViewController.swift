//
//  DetailedProjectViewController.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 07/10/24.
//

import UIKit

class DetailedProjectViewController: UIViewController {
    var project: Project?

    @IBOutlet weak var addReport: UIButton!
    @IBOutlet weak var detailedProjectSensors: UILabel!
    @IBOutlet weak var detailedImageView: UIImageView!
    @IBOutlet weak var detailedProjectReports: UILabel!
    @IBOutlet weak var detailedProjectParticipants: UILabel!
    @IBOutlet weak var detailedProjectLocation: UILabel!
    @IBOutlet weak var detailedProjectID: UILabel!
    @IBOutlet weak var detailedProjectTitle: UILabel!
    @IBOutlet weak var detailedView: UIView!
    @IBOutlet weak var detailedProjectDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        addReport.layer.cornerRadius = 10
        addReport.layer.masksToBounds = true
        detailedView.layer.cornerRadius = 20
            detailedView.layer.masksToBounds = true // Esto asegura que el contenido no sobresalga de la vista

        // Do any additional setup after loading the view.
        if let project = project {
                    // Aquí puedes configurar la vista con los detalles del proyecto
            detailedProjectTitle.text = project.title 
                    print("Detalles del proyecto: \(project)")
                }
        detailedProjectID.text = "Project ID: \(project?.projectID ?? "N/A")"

        detailedProjectLocation.text = project?.location
        detailedProjectParticipants.text = "\(project?.participants ?? 0) Participants"
        detailedProjectReports.text = "\(project?.reports ?? 0) Reports"
        detailedProjectDescription.text = project?.details.description
        if let imageUrl = project?.projectBanner {
                    detailedImageView.image = UIImage(named: imageUrl)
                } else {
                    detailedImageView.image = nil // O puedes establecer una imagen por defecto
                }
        if let activeSensors = project?.sensors.active {
            detailedProjectSensors.text = activeSensors.joined(separator: "\n") // Une los elementos con un salto de línea
        } else {
            detailedProjectSensors.text = "Sin datos"
        }


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
