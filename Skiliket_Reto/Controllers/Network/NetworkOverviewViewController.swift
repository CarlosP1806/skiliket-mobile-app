//
//  NetworkOverviewViewController.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 11/10/24.
//

import UIKit
import SwiftUI

class NetworkOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var overviewTableView: UITableView!

    var networkHealthData: [NetworkHealthResponse] = []
    var pollingTimer: Timer?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        // Start polling to fetch data every 5 seconds
        startPolling()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        summaryView.layer.cornerRadius = 30.0
        overviewTableView.backgroundColor = UIColor.black
        overviewTableView.delegate = self
        overviewTableView.dataSource = self
        overviewTableView.register(UITableViewCell.self, forCellReuseIdentifier: "chartCell")

        // Initial fetch of network health data
        fetchData()
    }

    // MARK: - UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Currently displaying one chart in the table view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chartCell", for: indexPath)
        
        // Remove any existing hosting controller's view
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }

        // Create a SwiftUI view and embed it in a hosting controller
        let chartView = NetworkHealthChartView(networkHealthData: networkHealthData)
        let hostingController = UIHostingController(rootView: chartView)
        
        // Set the hosting controller's view background to black
        hostingController.view.backgroundColor = UIColor.black

        // Add the hosting controller's view to the table cell
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(hostingController.view)

        // Set constraints for the hosting controller's view
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])

        hostingController.didMove(toParent: self)

        return cell
    }

    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250 // Set the desired height for the chart cell
    }

    // MARK: - Data Fetching and Polling

    // Fetch network health data and update table
    func fetchData() {
        Task {
            do {
                let tokenPTT = try await NetworkHealth.getToken()
                let newData = try await NetworkHealth.getNetworkHealth(token: tokenPTT!)
                
                // Append new data, ensuring unique timestamps
                self.networkHealthData.append(contentsOf: newData.filterUniqueTimestamps())
                
                // Reload table view to reflect the new data
                overviewTableView.reloadData()
            } catch {
                print("Error fetching network health data: \(error)")
            }
        }
    }

    // Start the polling process to fetch data every 5 seconds
    func startPolling() {
        pollingTimer?.invalidate() // Ensure any existing timer is invalidated before creating a new one
        pollingTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] timer in
            self?.fetchData()
        }
    }

    // Stop polling when the view disappears to save resources
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pollingTimer?.invalidate() // Stop the timer when not in view
    }
}


