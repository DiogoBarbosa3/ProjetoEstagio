//
//  Cart.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 06/06/2023.
//

import Foundation

class Cart{
    
    var beersToBuy = [BeerInfo:Int]()
    
    func addBeer(beer: BeerInfo) {
        
        
        if beersToBuy[beer] != nil {
            
            beersToBuy[beer] = beersToBuy[beer]! + 1
            return
            
        } else {
            beersToBuy[beer] = 1
            
            return
        }
        
        
        
    }
    
    func removeBeer(beer: BeerInfo){
        
        if beersToBuy[beer] != nil && beersToBuy[beer]! > 1 {
            beersToBuy[beer] = beersToBuy[beer]! - 1
            return
            
        }
        if beersToBuy[beer] == 1 {
            beersToBuy.removeValue(forKey: beer)
            return
        }
    }
    
    func beersList() -> [BeerInfo] {
        return Array(self.beersToBuy.keys)
    }
    
}



