//
//  BeerViewController.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 30/05/2023.
//

import UIKit

class BeerViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the back button
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
}
