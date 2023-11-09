//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by erika.talberga on 09/11/2023.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Card?
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var weaknessLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var resistanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: pokemon?.imageURL ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.cardImageView?.image = UIImage(data: data)
                    }
                }
            }
        }
        
        
        if let pokemon = pokemon {
            nameLabel.text = "Name: \(pokemon.name)"
            healthLabel.text = "HP: \(pokemon.hp ?? "N/A")"
            
            if let attacks = pokemon.attacks {
                attackLabel.text = "Attacks: \(attacks.map { $0.name ?? "N/A" }.joined(separator: ", "))"
            }
            
            if let weaknesses = pokemon.weaknesses {
                weaknessLabel.text = "Weaknesses: \(weaknesses.map { $0.type?.rawValue ?? "N/A" }.joined(separator: ", "))"
            } else {
                weaknessLabel.text = "Weaknesses: N/A"
            }
            
            if let ability = pokemon.ability {
                abilityLabel.text = "Ability: \(ability.name ?? "N/A")"
            } else {
                abilityLabel.text = "Ability: N/A"
            }
            
            if let resistances = pokemon.resistances {
                resistanceLabel.text = "Resistances: \(resistances.map { $0.type?.rawValue ?? "N/A" }.joined(separator: ", "))"
            } else {
                resistanceLabel.text = "Resistances: N/A"
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
