//
//  SensorSelectionViewController.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 14/10/24.
//

import UIKit

class SensorSelectionViewController: UIViewController {
    var selectedSensor: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func temperatureButtonPressed(_ sender: UIButton) {
        selectedSensor = "Temperature"
        performSegue(withIdentifier: "toCitySelection", sender: self)
    }
    
    @IBAction func humidityButtonPressed(_ sender: UIButton) {
        selectedSensor = "Humidity"
        performSegue(withIdentifier: "toCitySelection", sender: self)
    }

    @IBAction func smokeButtonPressed(_ sender: UIButton) {
        selectedSensor = "Smoke"
        performSegue(withIdentifier: "toCitySelection", sender: self)
    }

    @IBAction func lightButtonPressed(_ sender: UIButton) {
        selectedSensor = "Light"
        performSegue(withIdentifier: "toCitySelection", sender: self)
    }

    @IBAction func soundButtonPressed(_ sender: UIButton) {
        selectedSensor = "Sound"
        performSegue(withIdentifier: "toCitySelection", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCitySelection" {
            if let cityVC = segue.destination as? CitySelectionViewController {
                cityVC.selectedSensor = selectedSensor
            }
        }
    }
}
