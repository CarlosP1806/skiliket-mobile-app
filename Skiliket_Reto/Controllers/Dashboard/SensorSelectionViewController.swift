// SensorSelectionViewController.swift
// Skiliket_Reto
//
// Created by José Antonio Pacheco on 14/10/24.
//

import UIKit

class SensorSelectionViewController: UIViewController {
    var selectedSensor: String?
    var selectedCity: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func temperatureButtonPressed(_ sender: UIButton) {
        selectedSensor = "Temperature"
        performSegue(withIdentifier: "toGraphView", sender: self)
    }
    
    @IBAction func humidityButtonPressed(_ sender: UIButton) {
        selectedSensor = "Humidity"
        performSegue(withIdentifier: "toHumidityGraphView", sender: self)
    }

    @IBAction func smokeButtonPressed(_ sender: UIButton) {
        selectedSensor = "Smoke"
        performSegue(withIdentifier: "toSmokeGraphView", sender: self)
    }

    @IBAction func lightButtonPressed(_ sender: UIButton) {
        selectedSensor = "Light"
        performSegue(withIdentifier: "toGraphView", sender: self)
    }

    @IBAction func soundButtonPressed(_ sender: UIButton) {
        selectedSensor = "Sound"
        performSegue(withIdentifier: "toSoundGraphView", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGraphView" {
            if let graphVC = segue.destination as? GraphViewController {
                graphVC.selectedSensor = selectedSensor
                graphVC.selectedCity = selectedCity
            }
        } else if segue.identifier == "toHumidityGraphView" {
            if let humidityGraphVC = segue.destination as? HumidityGraphViewController {
                humidityGraphVC.selectedSensor = selectedSensor
                humidityGraphVC.selectedCity = selectedCity
            }
        } else if segue.identifier == "toSmokeGraphView" {
            if let smokeGraphVC = segue.destination as? SmokeGraphViewController {
                smokeGraphVC.selectedSensor = selectedSensor
                smokeGraphVC.selectedCity = selectedCity
            }
        } else if segue.identifier == "toSoundGraphView"{
            if let soundGraphVC = segue.destination as? SoundGraphViewController {
                soundGraphVC.selectedSensor = selectedSensor
                soundGraphVC.selectedCity = selectedCity
            }
        }
    }
}

