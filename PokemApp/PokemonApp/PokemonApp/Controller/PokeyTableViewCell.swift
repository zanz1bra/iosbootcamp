//
//  PokeyTableViewCell.swift
//  PokemonApp
//
//  Created by arturs.olekss on 08/11/2023.
//

import UIKit
import SDWebImage

class PokeyTableViewCell: UITableViewCell{
    
    @IBOutlet weak var pokeyImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var supertypeLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    
    func setupUI(withdDataFrom:Card){
        nameLabel.text = "Name: " + withdDataFrom.name
        hpLabel.text = "Health points: " + (withdDataFrom.hp ?? "0")
        supertypeLabel.text = (withdDataFrom.supertype ?? "")
        pokeyImageView.sd_setImage(with: URL(string:withdDataFrom.imageURL))
    }
}
