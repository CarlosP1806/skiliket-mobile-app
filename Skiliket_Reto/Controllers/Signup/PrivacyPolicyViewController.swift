//
//  PrivacyPolicyViewController.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 09/10/24.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Llamada para cargar el aviso de privacidad
        Task {
            await loadPrivacyPolicy()
        }
    }
    
    // Función para cargar el aviso de privacidad
    func loadPrivacyPolicy() async {
        do {
            let privacyPolicy = try await PrivacyPolicy.fetchProfile()
            updateUI(with: privacyPolicy)
        } catch {
            print("Error al cargar el aviso de privacidad: \(error)")
        }
    }

    // Función para actualizar la UI con el contenido del JSON
    func updateUI(with policy: PrivacyPolicy) {
        DispatchQueue.main.async {
            self.name.text = policy.privacyPolicy.title
            self.content.text = policy.privacyPolicy.content
        }
    }
}
