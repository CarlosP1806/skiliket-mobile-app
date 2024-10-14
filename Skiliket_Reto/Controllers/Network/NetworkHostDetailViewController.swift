//
//  NetworkHostDetailViewController.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 11/10/24.
//

import UIKit

class NetworkHostDetailViewController: UIViewController {
    
    var host: Response?
    
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
    @IBOutlet weak var vlanLabel: UILabel!
    
    
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

        hostnameLabel.text = host!.hostName
        macLabel.text = "MAC: \(host!.hostMAC)"
        ipLabel.text = "IP: \(host!.hostIP)"
        
        if(host!.pingStatus == "SUCCESS") {
            statusLabel.text = "Up"
        }
        else {
            statusLabel.text = "Down"
        }
        
        deviceImage.image = UIImage(named: "PC")
        
        
        var typeFormatted = host!.hostType
        if(typeFormatted == "End Host") {
            typeFormatted = "Skiliket"
        }
        typeLabel.text = typeFormatted
        
        connectedLabel.text = host!.connectedNetworkDeviceName
        
        interfaceLabel.text = host!.connectedInterfaceName
        
        if(host!.vlanID != nil) {
            vlanLabel.text = host!.vlanID
        }
        else {
            vlanLabel.text = "N/A"
        }
        
        // Get location based on ip
        let locationIPOctet = Int( host!.hostIP.split(separator: ".")[2])
        
        if(locationIPOctet! <= 30) {
            locationLabel.text = "Guadalajara"
        }
        else if(locationIPOctet! <= 60) {
            locationLabel.text = "Monterrey"
        }
        else if(locationIPOctet! <= 90) {
            locationLabel.text = "CDMX"
        }
        else {
            locationLabel.text = "Toronto"
        }
        
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
