//
//  ViewController.swift
//  PokemonApp
//
//  Created by arturs.olekss on 06/11/2023.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var pokey:[Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPokemonData()
    }
    
    func loadPokemonData(){
        let jsonUrl = "https://api.pokemontcg.io/v1/cards"
        guard let url = URL(string:jsonUrl) else { return }
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request){
            data,response,error in
            if error != nil{
                print((error?.localizedDescription)!)
            }
            dump(response)
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            do{
                let jsonData = try JSONDecoder().decode(Pokemon.self,from:data)
                dump(jsonData)
                self.pokey = jsonData.cards
                
                DispatchQueue.main.async {
                    self.tableViewOutlet.reloadData()
                }
                
            }catch{
                print("error::::",error)
            }
        }.resume()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokey.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell
        
        let card = pokey[indexPath.row]
        cell.nameLabel?.text = "Name: " + (card.name )
        cell.typeLabel?.text = "Type: " + (card.types?.joined(separator: ", ") ?? "N/A")
        
        
        return cell
    }

}






