//
//  NetworkDeviceDetailViewController.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 13/10/24.
//

import UIKit

class NetworkDeviceDetailViewController: UIViewController {
    
    var device: Respuesta?
    
    let CORNER_RADIUS = 30.0
    
    
    @IBOutlet weak var deviceImage: UIImageView!
    
    @IBOutlet weak var hostnameLabel: UILabel!
    @IBOutlet weak var macLabel: UILabel!
    @IBOutlet weak var ipLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var interfaceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var connectionView: UIView!
    @IBOutlet weak var deviceView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var connectedView: UIView!
    @IBOutlet weak var interfaceView: UIView!
    @IBOutlet weak var vlanView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        hostnameLabel.text = device!.hostname
        macLabel.text = "MAC: \(device!.macAddress)"
        ipLabel.text = "IP: \(device!.managementIPAddress)"
        
        if(device!.reachabilityStatus == "Reachable") {
            statusLabel.text = "Up"
        }
        else {
            statusLabel.text = "Down"
        }
        
        deviceImage.image = UIImage(named: "router")
        
        
        var typeFormatted = device!.errorDescription
        if(typeFormatted == "End device") {
            typeFormatted = "Skiliket"
        }
        typeLabel.text = device?.type
        
        connectedLabel.text = device?.connectedNetworkDeviceName.joined(separator: "\n")

        
        interfaceLabel.text = device!.connectedInterfaceName.joined(separator:"\n" )
        dateLabel.text = device!.lastUpdated
        
        locationLabel.text = device?.connectedNetworkDeviceIPAddress.joined(separator:"\n")
        bannerView.layer.cornerRadius = CORNER_RADIUS
        connectionView.layer.cornerRadius = CORNER_RADIUS
        deviceView.layer.cornerRadius = CORNER_RADIUS
        locationView.layer.cornerRadius = CORNER_RADIUS
        connectedView.layer.cornerRadius = CORNER_RADIUS
        interfaceView.layer.cornerRadius = CORNER_RADIUS
        vlanView.layer.cornerRadius = CORNER_RADIUS
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
