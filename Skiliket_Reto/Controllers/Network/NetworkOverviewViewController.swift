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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overviewTableView.backgroundColor = UIColor.black
        
        summaryView.layer.cornerRadius = 30.0
        overviewTableView.delegate = self
        overviewTableView.dataSource = self

        overviewTableView.register(UITableViewCell.self, forCellReuseIdentifier: "chartCell")

        // Fetch network health data asynchronously and reload the table when done
        Task {
            do {
                let tokenPTT = try await NetworkHealth.getToken()
                self.networkHealthData = try await NetworkHealth.getNetworkHealth(token: tokenPTT!)
                overviewTableView.reloadData()
            } catch {
                print("Error fetching network health data")
            }
        }
    }

    // MARK: - UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Assuming you want just one chart in the table for now
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
        return 200 // Set the desired height for the chart cell
    }
}
