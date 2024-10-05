//
//  InitialViewController.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 04/10/24.
//

import UIKit

class InitialViewController: UIViewController {
    
    
    @IBOutlet weak var SignupButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SignupButton.layer.cornerRadius = 10
        LoginButton.layer.cornerRadius = 10
    }
}
