//
//  Beer.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 01/06/2023.
//

import Foundation

class BeerInfo: Codable, Hashable {
    
    let id: Int
    let name, tagline, firstBrewed, beerDescription: String?
    let imageURL: String?
    let abv: Double?
    let ibu: Double?
    let targetFg: Int?
    let targetOg: Double?
    let ebc: Int?
    let srm, ph: Double?
    let attenuationLevel: Double?
    
    
    enum CodingKeys: String, CodingKey {
        
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case beerDescription = "description"
        case imageURL = "image_url"
        case abv, ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc, srm, ph
        case attenuationLevel = "attenuation_level"
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (first: BeerInfo, second: BeerInfo) -> Bool {
        return first.id == second.id
    }
    
}
