//
//  LogOutViewController.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 28/06/2023.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LogOutViewController: UIViewController {
    
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutButton.layer.borderWidth = 1.5
        logOutButton.layer.cornerRadius = 10.0
        logOutButton.layer.masksToBounds = true
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        let tapGestureRecognizerLogOutButton = UITapGestureRecognizer(target: self, action: #selector(didTapLogOutButton(_:)))
        
        logOutButton.addGestureRecognizer(tapGestureRecognizerLogOutButton)
    }
    
    @objc func didTapLogOutButton(_ sender: Any) {
        
        if let _ = GIDSignIn.sharedInstance()?.currentUser {
            
            GIDSignIn.sharedInstance()?.signOut()
            
        }
        
        let loginManager = LoginManager()
        if let _ = AccessToken.current {
            
            loginManager.logOut()
            
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
