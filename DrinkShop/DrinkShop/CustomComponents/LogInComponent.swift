//
//  LogInComponent.swift
//  DrinkShop
//
//  Created by Diogo Barbosa on 23/05/2023.
//

import UIKit

class LogInComponent: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    static let identifier = "LogInComponent"
    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           initSubviews()
       }

       override init(frame: CGRect) {
           super.init(frame: frame)
           initSubviews()
       }
    
    func initSubviews() {

            let nib = UINib(nibName: LogInComponent.identifier, bundle: nil)

            guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                                UIView else {fatalError("Unable to convert nib")}

            addSubview(view)

        }
            
        func configureImageAndText(image : UIImage, text : String){
            label.text = text
            imageView.image = image
        }


}
