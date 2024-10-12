//
//  NetworkHostDetailViewController.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 11/10/24.
//

import UIKit

class NetworkHostDetailViewController: UIViewController {
    
    var host: Response?
    
    
    @IBOutlet weak var hostnameLabel: UILabel!
    @IBOutlet weak var macLabel: UILabel!
    @IBOutlet weak var ipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        hostnameLabel.text = host!.hostName
        macLabel.text = "MAC: \(host!.hostMAC)"
        ipLabel.text = "IP: \(host!.hostIP)"
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
