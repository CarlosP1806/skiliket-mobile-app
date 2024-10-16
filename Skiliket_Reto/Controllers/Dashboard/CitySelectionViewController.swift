// CitySelectionViewController.swift
// Skiliket_Reto
//
// Created by José Antonio Pacheco on 14/10/24.
//

import UIKit

class CitySelectionViewController: UIViewController {
    var selectedCity: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cdmxButtonPressed(_ sender: UIButton) {
        selectedCity = "CDMX"
        performSegue(withIdentifier: "toSensorSelection", sender: self)
    }

    @IBAction func monterreyButtonPressed(_ sender: UIButton) {
        selectedCity = "Monterrey"
        performSegue(withIdentifier: "toSensorSelection", sender: self)
    }

    @IBAction func guadalajaraButtonPressed(_ sender: UIButton) {
        selectedCity = "Guadalajara"
        performSegue(withIdentifier: "toSensorSelection", sender: self)
    }

    @IBAction func torontoButtonPressed(_ sender: UIButton) {
        selectedCity = "Toronto"
        performSegue(withIdentifier: "toSensorSelection", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSensorSelection" {
            if let sensorVC = segue.destination as? SensorSelectionViewController {
                sensorVC.selectedCity = selectedCity
            }
        }
    }
}

