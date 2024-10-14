//
//  NetworkDeviceViewController.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 13/10/24.
//

import UIKit

class NetworkDeviceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var deviceTableView: UITableView!
    var devices:[Respuesta] = []

    @IBOutlet weak var summaryView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryView.layer.cornerRadius = 30.0
        
        Task {
            do {
                guard let tokenPTT = try await DeviceData.getToken() else {
                    print("No se pudo obtener un token válido.")
                    return
                }
                let deviceList = try await DeviceData.getDevices(token: tokenPTT)
                self.devices = deviceList
                deviceTableView.reloadData()
            } catch let error as DeviceDataError {
                switch error {
                case .TokenGenerationError:
                    print("Error al generar el token.")
                case .DeviceNotFound:
                    print("Dispositivos no encontrados.")
                }
            } catch {
                print("Error inesperado: \(error.localizedDescription)")
            }
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as! DeviceCell
        let currentDevice = devices[indexPath.row]
        
        cell.configure(type: currentDevice.type, hostname: currentDevice.hostname, status: currentDevice.reachabilityStatus)
                
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "deviceDetailSegue") {
            let nextView = segue.destination as! NetworkDeviceDetailViewController
            let index = deviceTableView.indexPathForSelectedRow?.row
            guard let index = index else {
                return
            }
            let device = devices[index]
            nextView.device = device  
        }
    }
}

class DeviceCell: UITableViewCell {
    
    @IBOutlet weak var hostView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var statusIndicator: UIView!
    @IBOutlet weak var hostnameLabel: UILabel!
    
    func configure(type: String, hostname: String, status: String) {
        
        var typeFormatted = type

    
        
        typeLabel.text = typeFormatted
        hostnameLabel.text = hostname
        statusIndicator.layer.cornerRadius =
        statusIndicator.frame.size.width / 2
        if(status == "Reachable") {
            statusIndicator.backgroundColor = .green
        }
        else {
            statusIndicator.backgroundColor = .red
        }
    }
}
