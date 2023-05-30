//
//  LoginViewController.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 18/05/2023.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logInMessage: UILabel!
    @IBOutlet weak var facebookLogin: LogInComponent!
    @IBOutlet weak var googleLogin: LogInComponent!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookLogin.layer.borderWidth = 1.5
        facebookLogin.layer.cornerRadius = 10.0
        facebookLogin.layer.masksToBounds = true
        
        googleLogin.layer.borderWidth = 1.5
        googleLogin.layer.cornerRadius = 10.0
        googleLogin.layer.masksToBounds = true
        
        
        
        
        if let image = UIImage(named: "google_logo") {
            
            googleLogin.configureImageAndText(image: image, text: "Sign up with Google")
            
        }
        
        let tapGestureRecognizerFacebookButton = UITapGestureRecognizer(target: self, action: #selector(didTapViewFacebookButton(_:)))
        
        let tapGestureRecognizerGoogleButton = UITapGestureRecognizer(target: self, action: #selector(didTapViewGoogleButton(_:)))
        
        facebookLogin.addGestureRecognizer(tapGestureRecognizerFacebookButton)
        updateMessage(with: Profile.current?.name )
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        googleLogin.addGestureRecognizer(tapGestureRecognizerGoogleButton)
        updateMessage(with: GIDSignIn.sharedInstance()?.currentUser?.profile.givenName)
        
        
        
    }
    
    @objc func didTapViewFacebookButton(_ sender: Any) {
        
        if let _ = GIDSignIn.sharedInstance()?.currentUser?.profile.name {
            logInMessage.text = "Log Out From Google!"
            return
        }
        
        // 1
        let loginManager = LoginManager()
        
        
        
        if let _ = AccessToken.current {
            // Access token available -- user already logged in
            // Perform log out
            
            // 2
            loginManager.logOut()
            updateMessage(with: nil)
            
        } else {
            // Access token not available -- user already logged out
            // Perform log in
            
            // 3
            loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
                
                // 4
                // Check for error
                guard error == nil else {
                    // Error occurred
                    print(error!.localizedDescription)
                    return
                }
                
                // 5
                // Check for cancel
                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
                
                
                // 7
                Profile.loadCurrentProfile { (profile, error) in
                    self?.updateMessage(with: Profile.current?.name)
                }
            }
            
            
        }
    }
    
    @objc func didTapViewGoogleButton(_ sender: Any) {
        
        if let _ = Profile.current?.name {
            logInMessage.text = "Log Out From Facebook!"
            return
        }
        
        if let _ = GIDSignIn.sharedInstance()?.currentUser {
            
            GIDSignIn.sharedInstance()?.signOut()
            updateMessage(with: nil)
            
        }else{
            
            GIDSignIn.sharedInstance()?.signIn()
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(userDidSignInGoogle(_:)),
                                                   name: .signInGoogleCompleted,
                                                   object: nil)
            
        }
        
    }
    
    @objc private func userDidSignInGoogle(_ notification: Notification) {
        // Update screen after user successfully signed in
        updateMessage(with: GIDSignIn.sharedInstance()?.currentUser.profile.name)
    }
    
    
    
    
    
    private func updateMessage(with name: String?) {
        // 2
        guard let name = name else {
            logInMessage.text = "Login"
            return
        }
        
        // User already logged in
        logInMessage.text = "\(name)!"
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}

