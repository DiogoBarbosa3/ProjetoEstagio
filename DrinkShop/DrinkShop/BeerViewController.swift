//
//  BeerViewController.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 30/05/2023.
//

import UIKit

class BeerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var beers: [BeerInfo]
    
    required init?(coder aDecoder: NSCoder) {
        self.beers = [BeerInfo] ()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the back button
        self.navigationController?.navigationBar.isHidden = true
        
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
        
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
        let addAction = UIContextualAction(style: .normal, title: "Add Cart") { (action, view, completionHandler) in
            // Perform the action when "Add Cart" is tapped
            
            print("Added") // Indicate that the action was performed
        }
        addAction.backgroundColor = .green // Customize the background color of the action button
        
        let configuration = UISwipeActionsConfiguration(actions: [addAction])
        return configuration
    }
    
    
}


var imageCache = NSCache<AnyObject,AnyObject>()
extension UIImageView {
    func load(urlString: String) {
        
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
