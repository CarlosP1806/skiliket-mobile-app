//
//  CreateReportViewController.swift
//  Skiliket_Reto
//
//  Created by Eashley Brittney Martinez Vergara on 07/10/24.
//

import UIKit

class CreateReportViewController: UIViewController {

    @IBOutlet weak var createReportView: UIView!
    override func viewDidLoad() {
        createReportView.layer.cornerRadius = 20
            createReportView.layer.masksToBounds = true 
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
