//
//  NetworkHostsViewController.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 11/10/24.
//

import UIKit

class NetworkHostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var hostTableView: UITableView!
    var hosts:[Response] = []

    @IBOutlet weak var summaryView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        summaryView.layer.cornerRadius = 30.0
        
        Task {
            do {
                let tokenPTT = try await Welcome.getToken()
                let hostList = try await Welcome.getHosts(token: tokenPTT!)
                self.hosts = hostList
                hostTableView.reloadData()                
            } catch {
                print("Error fetching hosts")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "hostCell", for: indexPath) as! HostCell
        let currentHost = hosts[indexPath.row]
        
        cell.configure(type: currentHost.hostType, hostname: currentHost.hostName, status: currentHost.pingStatus)
                
        return cell
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





class HostCell: UITableViewCell {
    
    @IBOutlet weak var hostView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var hostnameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    func configure(type: String, hostname: String, status: String) {
        hostView.layer.cornerRadius = 20.0
        
        typeLabel.text = type
        hostnameLabel.text = hostname
        statusLabel.text = status
    }
}
