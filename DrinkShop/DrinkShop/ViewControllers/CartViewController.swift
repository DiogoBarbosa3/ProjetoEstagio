//
//  CartViewController.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 06/06/2023.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cart: Cart = Cart()
    var beers: [BeerInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the back button
        self.navigationController?.navigationBar.isHidden = true
        
       
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            let tabbar = tabBarController as! TabbarController
            cart = tabbar.cart
            beers = cart.beersList()
            
            tableView.reloadData()
        }
        
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rate = self.beers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        
        cell.ImageView.load(urlString: rate.imageURL!)
        cell.NameLabel.text = rate.name
        
        cell.SubButton.tag = indexPath.row
        cell.AddButton.tag = indexPath.row
        
        cell.SubButton.addTarget(self, action: #selector(subButtonAction), for: .touchUpInside)
        cell.AddButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        
        guard let _ = self.cart.beersToBuy[rate] else {
            
            return cell
        }
        
        cell.CounterLabel.text = String(self.cart.beersToBuy[rate]!)
        
        
        return cell}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func subButtonAction(sender: UIButton){
        self.cart.removeBeer(beer: self.beers[sender.tag])
        beers = cart.beersList()
        self.tableView.reloadData()
        return}
    
    @objc func addButtonAction(sender: UIButton){
        self.cart.addBeer(beer: self.beers[sender.tag])
        beers = cart.beersList()
        self.tableView.reloadData()
        return
    }
    
    
    
    
    
    
}


