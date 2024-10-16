//
//  HumidityGraphViewController.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 15/10/24.
//

import UIKit
import SwiftUI

class HumidityGraphViewController: UIViewController {
    var selectedSensor: String?
    var selectedCity: String?

    @IBOutlet weak var graphContainerView: UIView!

    // Create an instance of HumidityData (ObservableObject)
    var humidityData = HumidityData()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Ensure sensor and city values are not nil
        guard let sensor = selectedSensor, let city = selectedCity else {
            print("Error: selectedSensor or selectedCity is nil")
            return
        }

        title = "\(sensor) in \(city)"
        
        // Load and initialize the graph
        loadGraph(sensor: sensor, city: city)
    }

    func loadGraph(sensor: String, city: String) {
        // Create the graph view and add it to the container
        let graphView = UIHostingController(rootView: HumidityLineChartUIView(humidityData: humidityData))
        addChild(graphView)
        
        // Set the hosting controller's view background to black
        graphView.view.backgroundColor = .black
        
        // Make sure the graphView matches the container's bounds
        graphView.view.translatesAutoresizingMaskIntoConstraints = false
        graphContainerView.addSubview(graphView.view)
        
        // Pin the graphView's edges to the graphContainerView's edges
        NSLayoutConstraint.activate([
            graphView.view.leadingAnchor.constraint(equalTo: graphContainerView.leadingAnchor),
            graphView.view.trailingAnchor.constraint(equalTo: graphContainerView.trailingAnchor),
            graphView.view.topAnchor.constraint(equalTo: graphContainerView.topAnchor),
            graphView.view.bottomAnchor.constraint(equalTo: graphContainerView.bottomAnchor)
        ])
        
        graphView.didMove(toParent: self)
        
        // Start fetching the data
        startDataCensus(sensor: sensor, city: city, updateInterval: 5.0)
    }

    // Function to start periodic data fetching
    func startDataCensus(sensor: String, city: String, updateInterval: TimeInterval) {
        Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { timer in
            self.fetchData(sensor: sensor, city: city)
        }
    }

    // Function to fetch sensor data from the server
    func fetchData(sensor: String, city: String) {
        let urlString = "http://localhost:8765/\(city)/\(sensor)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(String(describing: error))")
                return
            }

            do {
                let humidityPT = try JSONDecoder().decode(HumidityPT.self, from: data)
                let newHumidity = Humidity(value: String(humidityPT.humidity), timeStamp: Date())

                // Add the new humidity to the data array
                DispatchQueue.main.async {
                    self.humidityData.addHumidity(newHumidity)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}

