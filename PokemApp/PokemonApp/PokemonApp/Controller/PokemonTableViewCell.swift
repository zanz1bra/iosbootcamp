//
//  PokemonTableViewCell.swift
//  PokemonApp
//
//  Created by erika.talberga on 08/11/2023.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
