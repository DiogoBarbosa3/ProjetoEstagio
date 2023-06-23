//
//  BeerDetailsViewController.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 14/06/2023.
//

import UIKit

class BeerDetailsViewController: UIViewController {
    
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var cervejeiroTips: UILabel!
    @IBOutlet weak var percentAlcool: UILabel!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    var topTitle: String?
    
    var auxDescricao:String = ""
    var auxCervejeiroTips:String = ""
    var auxPercentAlcool:String = ""
    var auxBeerName:String = ""
    var auxBeerImage = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setUpLayoutInfo()
    }
    
    private func setUpLayoutInfo(){
        let boldAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
           ]
        let regularAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 15.0)!
           ]
        
        self.title = topTitle!
        
        let boldDescricao = NSAttributedString(string: "About\n", attributes: boldAttribute)
        let regularDescricao = NSAttributedString(string: self.auxDescricao, attributes: regularAttribute)
        let newDescricao = NSMutableAttributedString()
        newDescricao.append(boldDescricao)
        newDescricao.append(regularDescricao)
        self.descricao.attributedText = newDescricao
        
        let boldCervejeiroTips = NSAttributedString(string: "Tip\n", attributes: boldAttribute)
        let regularCervejeiroTips = NSAttributedString(string: self.auxCervejeiroTips, attributes: regularAttribute)
        let newCervejeiroTips = NSMutableAttributedString()
        newCervejeiroTips.append(boldCervejeiroTips)
        newCervejeiroTips.append(regularCervejeiroTips)
        self.cervejeiroTips.attributedText = newCervejeiroTips
        
        let regularAtribbutePercentAlcool = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 20.0)! ]
        let boldPercentAlcool = NSAttributedString(string: "Alcohol%: ", attributes: boldAttribute)
        let regularPercentAlcool = NSAttributedString(string: self.auxPercentAlcool, attributes: regularAtribbutePercentAlcool)
        let newPercentAlcool = NSMutableAttributedString()
        newPercentAlcool.append(boldPercentAlcool)
        newPercentAlcool.append(regularPercentAlcool)
        self.percentAlcool.attributedText = newPercentAlcool
        
        let boldAttributeBeerName = [ NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 35.0)!]
        self.beerName.attributedText = NSAttributedString(string: self.auxBeerName, attributes: boldAttributeBeerName)
        
        self.beerImage.image = auxBeerImage.image
    }
    
    
    
    
}
