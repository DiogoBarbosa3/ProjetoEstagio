//
//  Cart.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 06/06/2023.
//

import Foundation

class Cart{
    
    var beersToBuy = [BeerInfo:Int]()
    
    func addBeer(beer: BeerInfo,quantity: Int) {
        
        
        if beersToBuy[beer] != nil {
            
            beersToBuy[beer] = beersToBuy[beer]! + quantity
            return
            
        } else {
            beersToBuy[beer] = quantity
            
            return
        }
        
        
        
    }
    
    func removeBeer(beer: BeerInfo,quantity: Int){
        
        if beersToBuy[beer] != nil && beersToBuy[beer]! > 1 {
            beersToBuy[beer] = beersToBuy[beer]! - quantity
            return
            
        }
        if beersToBuy[beer] == 1 {
            beersToBuy.removeValue(forKey: beer)
            return
        }
        
    return}
    
}



