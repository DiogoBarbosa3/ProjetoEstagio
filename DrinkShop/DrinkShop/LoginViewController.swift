//
//  LoginViewController.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 18/05/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var facebookLogin: LogInComponent!
    @IBOutlet weak var googleLogin: LogInComponent!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = UIImage(named: "google_logo") {
            
            googleLogin.configureImageAndText(image: image, text: "Sign up with Google")
            
        }
        
        
    }
    
    
}

