//
//  ViewController.swift
//  PokemonApp
//
//  Created by arturs.olekss on 06/11/2023.
//

import UIKit

class ViewController: UIViewController {

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
                
                DispatchQueue.main.async{
                    self.tableViewOutlet.reloadData()
                }
                
                
            }catch{
                print("error::::",error)
            }
        }.resume()
        
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView:UITableView,numberOfRowsInSection section: Int)->Int{
        return pokey.count
    }
    
    func tableView(_ tableView:UITableView,cellForRowAt indexPath:IndexPath)->UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? PokeyTableViewCell else{
            return UITableViewCell()
        }
        let poke = pokey[indexPath.row]
        cell.setupUI(withdDataFrom: poke)
        
        return cell
    }
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath)->CGFloat{
        return 250
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokeymon"{
//            guard let destinationVC = segue.destination as? ViewController, let row = tableViewOutlet.indexPathForSelectedRow?.row else{
//                return
//            }
//            destinationVC.pokey = pokey[r]
        }
    }
}

