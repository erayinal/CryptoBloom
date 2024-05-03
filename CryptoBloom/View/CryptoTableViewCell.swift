//
//  CryptoTableViewCell.swift
//  CryptoBloom
//
//  Created by Eray İnal on 3.05.2024.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var prosConsLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    public var item : Crypto! {
        didSet{     //14 Tanımladığı an ben neyi yapayım onu sorar
            self.nameLabel.text = item.currency
            self.priceLabel.text = item.price
            let randomDouble = Double.random(in: -5.71...6.14)
            self.prosConsLabel.text = String(randomDouble)
            self.prosConsLabel.textColor = .white
            
            if(randomDouble>0){
                self.prosConsLabel.backgroundColor = .green
                //self.prosConsLabel.textColor = .green
            }else if(randomDouble==0){
                self.prosConsLabel.backgroundColor = .gray
            }else{
                self.prosConsLabel.backgroundColor = .red
            }
        }
    }
    
    
}
