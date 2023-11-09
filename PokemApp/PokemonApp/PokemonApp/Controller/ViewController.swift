//
//  ViewController.swift
//  PokemonApp
//
//  Created by arturs.olekss on 06/11/2023.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var pokey:[Card] = []
    var allPokemon: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        searchBar.delegate = self
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
                self.allPokemon = self.pokey
                
                DispatchQueue.main.async {
                    self.tableViewOutlet.reloadData()
                }
                
            }catch{
                print("error::::",error)
            }
        }.resume()
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterPokemon(searchText)
        tableViewOutlet.reloadData()
    }
    
    func filterPokemon(_ searchText: String) {
        if searchText.isEmpty {
            pokey = allPokemon
        } else {
            pokey = allPokemon.filter { card in
                let nameMatch = card.name.lowercased().contains(searchText.lowercased())
                let typeMatch = card.types?.contains { $0.lowercased().contains(searchText.lowercased())} ?? false
                let seriesMatch = card.series?.rawValue.lowercased().contains(searchText.lowercased()) ?? false
                
                return nameMatch || typeMatch || seriesMatch
            }
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell
        
        let card = pokey[indexPath.row]
        cell.nameLabel?.text = "Name: " + (card.name )
        cell.typeLabel?.text = "Type: " + (card.types?.joined(separator: ", ") ?? "N/A")

        if let url = URL(string: card.imageURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.cardImageView?.image = UIImage(data: data)
                    }
                }
            }
        }
        cell.seriesLabel.text = "Series: " + (card.series)!.rawValue
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "pokemonDetailVC" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController, let indexPath = tableViewOutlet.indexPathForSelectedRow
            else { return }
            destinationVC.pokemon = pokey[indexPath.row]
        }
    }
}



