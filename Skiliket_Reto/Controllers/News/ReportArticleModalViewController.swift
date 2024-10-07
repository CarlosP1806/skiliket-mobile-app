//
//  ReportArticleModalViewController.swift
//  Skiliket_Reto
//
//  Created by Carlos Alberto Paez De la Cruz on 06/10/24.
//

import UIKit

class ReportArticleModalViewController: UIViewController {
    
    @IBAction func closeButton(_ sender: Any) {
       dismiss(animated: true)
    }
    @IBOutlet weak var reportReasonPicker: UIPickerView!
    
    var reportOptions = [
        "Fake news",
        "Bullying or harrassment",
        "Incited to suicide",
        "Promotion of illegal items",
        "Fraud or scam",
        "Hate speech"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reportReasonPicker.dataSource = self
        reportReasonPicker.delegate = self
    }

}

extension ReportArticleModalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reportOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reportOptions[row]
    }
}
