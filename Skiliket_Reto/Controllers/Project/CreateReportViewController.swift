//
//  CreateReportViewController.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 07/10/24.
//

import UIKit

class CreateReportViewController: UIViewController {

    @IBOutlet weak var createReport: UIButton!
    @IBOutlet weak var createReportView: UIView!
    override func viewDidLoad() {
        createReport.layer.cornerRadius = 10
        createReport.layer.masksToBounds = true
        createReportView.layer.cornerRadius = 20
            createReportView.layer.masksToBounds = true 
        super.viewDidLoad()
        createReport.addTarget(self, action: #selector(createReportTapped), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    @objc func createReportTapped() {
           // Mostrar una alerta indicando que el proyecto se creó con éxito
           let successAlert = UIAlertController(title: "Success", message: "The report was created successfully", preferredStyle: .alert)
           
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
