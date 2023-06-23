//
//  BeerViewController.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 30/05/2023.
//

import UIKit

class BeerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var beers: [BeerInfo] = []
    var cart: Cart = Cart()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        retrieveData { result in
            switch result {
            case .success(let cellInfo):
                DispatchQueue.main.async {
                    
                    self.beers = cellInfo
                    self.tableView.reloadData()
                    
                }
            case .failure(let error):
                DispatchQueue.main.async{
                    print(error)
                }
            }
        }
        
        let tabbar = tabBarController as! TabbarController
        cart = tabbar.cart
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
        self.navigationController?.navigationBar.isHidden = true
        }
    
    private func retrieveData(completion: @escaping (Result<[BeerInfo], Error>) -> Void) {
        let urlString = "https://api.punkapi.com/v2/beers"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data not found"])))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let json = try decoder.decode([BeerInfo].self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rate = self.beers[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeersCustomCell", for: indexPath) as! BeersTableViewCell
        
        cell.ImageView.load(urlString: rate.imageURL!)
        cell.Label.text = rate.name
        
        
        
        return cell}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "Add 1 to Cart") { (action, view, completionHandler) in
            
            self.cart.addBeer(beer: self.beers[indexPath.section])
            
        }
        addAction.backgroundColor = .green // Customize the background color of the action button
        
        
        
        
        let configuration = UISwipeActionsConfiguration(actions: [addAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BeerDetailsViewController") as? BeerDetailsViewController {
            let rate = self.beers[indexPath.section]
            vc.topTitle = rate.name
            vc.auxBeerImage.load(urlString: rate.imageURL!)
            vc.auxBeerName = rate.name!
            vc.auxPercentAlcool = String(rate.abv!)
            vc.auxCervejeiroTips = rate.brewers_tips!
            vc.auxDescricao = rate.beerDescription!
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension UIImageView {
    func load(urlString: String) {
        ImageLoader.loadImage(urlString: urlString) { [weak self] image in
            self?.image = image
            
        }
    }
}
